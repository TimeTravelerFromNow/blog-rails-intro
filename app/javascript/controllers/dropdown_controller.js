import { Controller } from "@hotwired/stimulus"
import {computePosition,
  flip,
  shift,
  offset,
} from '@floating-ui/dom';

export default class extends Controller {
  static targets = [ 'flButton',  'flMenu' ]

  clearOpened() {
    const menus = document.querySelectorAll(".fl-menu");

    for ( let m of menus) {
      m.style.display = 'none';
    }
  }

  connect() {
  }

  ddClicked(event) {
    if (this.flMenuTarget.style.display == 'block')
    {
      this.flMenuTarget.style.display = 'none'
      this.clearOpened();
    }
    else
    {
      this.clearOpened();
      this.flMenuTarget.style.display = 'block'
    }
    this.flPos();
  }

  flPos() {
    this.flMenuTarget.style.minWidth = this.flButtonTarget.style.width;
    computePosition(this.flButtonTarget, this.flMenuTarget, {
      placement: 'bottom',
      middleware: [offset(6), flip(), shift({padding: 5})],
    }).then(({x, y}) => {
      Object.assign(this.flMenuTarget.style, {
        left: `${x}px`,
        top: `${y}px`,
      });
    });
  }
}