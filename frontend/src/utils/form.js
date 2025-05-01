export function objectToFormData(obj) {
  const form = new FormData();
  for (let property in obj) {
    if (!Object.prototype.hasOwnProperty.call(obj, property) || obj[property] === undefined || obj[property] === null) {
      continue;
    }

    if (obj[property] instanceof Date) {
      form.append(property, obj[property].toISOString());
    } else if (obj[property] instanceof File) {
      form.append(property, obj[property]);
    } else if (typeof obj[property] === 'object' && !(obj[property] instanceof File)) {
      objectToFormData(obj[property], form, property);
    } else {
      form.append(property, obj[property]);
    }
  }

  return form;
}
