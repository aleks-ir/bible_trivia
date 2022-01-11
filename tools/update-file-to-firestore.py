# SETTING UP YOUR VIRTUAL ENVIRONMENT
# For Mac
# pip install virtualenv
# virtualenv <your-env>
# source tutoring/bin/activate
# tutoring/bin/pip install google-cloud-firestore

# For Window
# pip install virtualenv
# virtualenv <your-env>
# <your-env>\Scripts\activate
# <your-env>\Scripts\pip.exe install google-cloud-firestore

# To run add collection use: python update-file-to-firestore.py add trivia exodus_1.json
# To run set collection use: python update-file-to-firestore.py set trivia exodus_1.json

import sys
import json
import firebase_admin
from firebase_admin import credentials
from firebase_admin import firestore

cred = credentials.Certificate('service_account.json')
firebase_admin.initialize_app(cred)

db = firestore.client()


class UpdateFileToFirestore:
    def __init__(self) -> None:

        self.method = sys.argv[1:][0]
        self.collection_name = sys.argv[1:][1]
        self.json_data = sys.argv[1:][2]

    @property
    def method(self):
        return self._method

    @method.setter
    def method(self, val):
        if val == 'set' or val == 'add':
            self._method = val
        else:
            print(f'Wrong method {val}, use set or add')

    @property
    def json_data(self):
        return self._json_data

    @json_data.setter
    def json_data(self, val):
        if val:
            try:
                f = open(val, )
                data = json.load(f)
                f.close()
                self._json_data = data
            except Exception as e:
                print(f'FILE EXCEPTION: {str(e)}')
        else:
            print(f'Wrong file path {val}')

    def upload(self):
        if self.json_data and self.method:

            for idx, item in enumerate(self.json_data):
                if self.method == 'set':
                    self.set(item)
                else:
                    self.add(item)

                if idx == len(self.json_data) - 1:
                    print('****SUCCESS UPLOAD*****')

    def add(self, item):
        return db.collection(self.collection_name).add(item)

    def set(self, item):
        return db.collection(self.collection_name).document(str(item['book'] + '_' + str(item['chapter']))).set(item)


fileToFirestore = UpdateFileToFirestore()
fileToFirestore.upload()
