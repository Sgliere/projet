import { Component, Input } from '@angular/core';
import { Hero } from './hero';
// import { Location } from '@angular/common';

@Component({
  selector: 'hero-detail',
  templateUrl: './hero-detail.component.html',
  styleUrls: ['./app.component.css']
})
export class HeroDetailComponent {
  @Input() hero: Hero;
// constructor(
//   private location: Location
// ) {}
//   goBack(): void {
//   this.location.back();
//   }
}
