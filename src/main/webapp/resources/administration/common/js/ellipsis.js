// Arno Gideonse
// http://weblog.scanyours.com/2011/02/07/howto-implementing-text-overflow-ellipsis-for-firefox-using-mootools-1-3/

(function($) {

   Element.implement({

      ellipsis: function(enableUpdating) {

         var s = document.documentElement.style;
         if (!('textOverflow' in s || 'OTextOverflow' in s)) {

            if (this.getStyle("overflow") == "hidden") {

               var t = this.clone(true).setStyles({
                  'position': 'absolute',
                  'width': 'auto',
                  'max-width': 'inherit',
                  'overflow': 'visible'
               }).inject(this, 'after');

               var text = originalText = this.get('html');
               while (text.length > 0 && t.getSize().x > this.getSize().x) {

                  text = text.substr(0, text.length - 1);
                  t.set('html', text + "\u2026");

               }

               this.set('html', t.get('html'));
               t.destroy();

               if (enableUpdating == true) {

                  var oldW = this.getSize().x;
                  setInterval(function() {

                     if (this.getSize().x != oldW) {

                        oldW = this.getSize().x;
                        this.set('html', originalText);
                        this.ellipsis();

                     }

                  }.bind(this), 200);

               }

            }

         }
         //console.log(this.get('html'));
         return this;

      }

   });

})();