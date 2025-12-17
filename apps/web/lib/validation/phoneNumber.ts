/**
 * Philippine mobile number validation regex
 * Matches formats:
 * - 09XXXXXXXXX (11 digits starting with 09)
 * - +639XXXXXXXXX (13 characters starting with +639)
 */
export const PHILIPPINE_MOBILE_REGEX = /^(09|\+639)\d{9}$/;

/**
 * Validates if a string is a valid Philippine mobile number
 * @param phoneNumber - The phone number to validate
 * @returns true if valid, false otherwise
 */
export function isValidPhilippineMobile(phoneNumber: string): boolean {
  return PHILIPPINE_MOBILE_REGEX.test(phoneNumber);
}

/**
 * Error message for invalid Philippine mobile numbers
 */
export const PHILIPPINE_MOBILE_ERROR_MESSAGE =
  "Please enter a valid Philippine mobile number (e.g., 09171234567 or +639171234567)";
