import { CONTACT_TYPES } from './contact-types';
import { MARITAL_STATUSES } from './marital-statuses';
import { PERSON_TYPES } from './person-types';
import { STATUSES } from './statuses';

export const CUSTOMER_DEFAULT = () => ({
  id: null,
  note: null,
  registered_at: null,
  status: STATUSES.active.value,
  person: {
    name: null,
    person_type: PERSON_TYPES.individual.value,
    cpf: null,
    rg: null,
    issuing_agency: null,
    birth_date: null,
    marital_status: MARITAL_STATUSES.single.value,
    cnpj: null,
    state_registration: null,
    trade_name: null,
    address: {
      id: null,
      street: null,
      number: null,
      complement: null,
      zip_code: null,
      neighborhood: null,
      city_id: null
    },
    contacts: [
      { id: null, contact_type: CONTACT_TYPES.email.value, email: null, mobile_number: null },
      { id: null, contact_type: CONTACT_TYPES.mobile.value, email: null, mobile_number: null },
      { id: null, contact_type: CONTACT_TYPES.mobile.value, email: null, mobile_number: null },
      { id: null, contact_type: CONTACT_TYPES.mobile.value, email: null, mobile_number: null }
    ]
  }
});
