export interface Clinic {
    "cid": string;
    "phone": string;
    "fax": string;
    "road": string;
    "city": string;
    "province": string;
    "pcode": string;
}

export interface Employe {
    "eid": string;
    "cid": string;
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
    "ownerid": string;
    "cid": string;
    "name": string;
    "phone": string;
    "address": string;
}

export interface Pet {
    "ownerid": string;
    "cid": string;
    "petid": string;
    "name": string;
    "specie": string;
    "description": string;
    "dob": Date;
    "status": string;
}

export interface Treatment {
    "treatid": string;
    "description": string;
    "tcost": string;
}

export interface Physical_exam {
    "eid": string;
    "ownerid": string;
    "cid": string;
    "petid": string;
    "examID": string;
    "examDate": Date;
    "examTime": string;
    "description": string;
}

export interface ProposedTreatment {
    "treatid": string;
    "examID": string;
    "ownerid": string;
    "cid": string;
    "petid": string;
    "quantity": string;
    "sDate": Date;
    "eDate": Date;
}

export interface Enrollment {
    "enID": string;
    "ownerid": string;
    "cid": string;
    "petid": string;
    "enrol_date": Date;
}
