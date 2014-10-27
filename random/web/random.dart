import 'dart:html';
import 'dart:math';

void main() {
  Random r = new Random();
  for(int i = 0; i < 15; i++)
    print(r.nextInt(99));
}

void reverseText(MouseEvent event) {
  var text = querySelector("#sample_text_id").text;
  var buffer = new StringBuffer();
  for (int i = text.length - 1; i >= 0; i--) {
    buffer.write(text[i]);
  }
  querySelector("#sample_text_id").text = buffer.toString();
}
