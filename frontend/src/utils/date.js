export function stringToDate(value = null) {
  if (value == null) return null;
  const [year, month, day] = value.split('-');
  return new Date(year, month - 1, day);
}

export function stringToDatetime(value = null) {
  if (value == null) return null;
  return new Date(value);
}
