import { Time } from '@angular/common';

export interface Clinic {
    "cID": string;
    "phone": string;
    "fax": string;
    "road": string;
    "city": string;
    "province": string;
    "pcode": string;
}

export interface Employe {
    "eIP": string;
    "cID": string;
    "nas": string;
    "name": string;
    "surname": string;
    "phone": string;
    "dob": Date;
    "sex": string;
    "position": string;
    "salary": number;
    "address": string;
}

export interface Owner {
    "ownerID": string;
    "cID": string;
    "name": string;
    "city": string;
    "province": string;
    "pcode": string;
}

export interface Pet {
    "ownerID": string;
    "cID": string;
    "petID": string;
    "name": string;
    "specie": string;
    "description": string;
    "dob": Date;
    "status": string;
}

export interface Treatment {
    "treatID": string;
    "description": string;
    "tcost": string;
}

export interface Physical_exam {
    "eID": string;
    "ownerID": string;
    "cID": string;
    "petID": string;
    "examID": string;
    "examDate": Date;
    "examTime": Time;
    "description": string;
}

export interface ProposedTreatment {
    "treatID": string;
    "examID": string;
    "ownerID": string;
    "cID": string;
    "petID": string;
    "quantity": string;
    "sDate": Date;
    "eDate": Date;
}

export interface Enrollment {
    "enID": string;
    "ownerID": string;
    "cID": string;
    "petID": string;
    "enrol_date": Date;
}