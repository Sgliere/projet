import { Injectable }    from '@angular/core';
import { Headers, Http } from '@angular/http';
import 'rxjs/add/operator/toPromise';
import { Student } from './student';

@Injectable()
export class StudentService {
  
  private headers = new Headers({'Content-Type': 'application/json'});
  private studentUrl = 'students.json';  

  constructor(private http: Http) { }
  getStudents(): Promise<Student[]> {
    return this.http.get(this.studentUrl)
               .toPromise()
               .then(response => response.json().data as Student[])
               .catch(this.handleError);
  }
  getStudent(id: number): Promise<Student> {
    const url = '${this.studentUrl}/${id}';
    return this.http.get(url)
      .toPromise()
      .then(response => response.json().data as Student)
      .catch(this.handleError);
  }

  private handleError(error: any): Promise<any> {
    console.error('An error occurred', error); // for demo purposes only
    return Promise.reject(error.message || error);
  }
}