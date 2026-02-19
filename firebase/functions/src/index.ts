import * as admin from "firebase-admin";
import * as functions from "firebase-functions";

admin.initializeApp();

const db = admin.firestore();

/**
 * getWelcomeMessage — callable function.
 *
 * Returns the personalised welcome message stored in `users/{uid}`.
 * Creates a default document on first call if none exists.
 *
 * Called from the Flutter app via `FirebaseFunctions.instance.httpsCallable('getWelcomeMessage')`.
 */
export const getWelcomeMessage = functions.https.onCall(
  async (_data, context) => {
    if (!context.auth) {
      throw new functions.https.HttpsError(
        "unauthenticated",
        "The function must be called while authenticated."
      );
    }

    const uid = context.auth.uid;
    const displayName = context.auth.token.name ?? "User";
    const docRef = db.collection("users").doc(uid);
    const snap = await docRef.get();

    if (!snap.exists) {
      // Bootstrap the user document on first visit.
      const defaultMessage = `Welcome, ${displayName}! 🎉`;
      await docRef.set({
        message: defaultMessage,
        displayName,
        createdAt: admin.firestore.FieldValue.serverTimestamp(),
      });
      return { message: defaultMessage };
    }

    return { message: snap.data()?.message ?? `Welcome back, ${displayName}!` };
  }
);
