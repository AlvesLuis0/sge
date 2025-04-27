export function stringToDate(value = null) {
  if (value == null) return null;
  return new Date(value);
}
