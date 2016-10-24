<p>Текстовый сапер:</p>

<ol>
<li>Поле: X*Y (3*3)</li>
<li>Количество мин: N (2)</li>
<li>Вывод поля на экран (опционально с картой мин):</li>
<li>Если все пустые поля открыты, перейти к 7.</li>
<li>Ход игрока: [A,B] ([0,0])</li>
<li>Если клетка пустая, перейти к п.3</li>
<li>Если в клетке мина, перейти к 7.</li>
<li>Вывести результат игры - win/lose.</li>
</ol>

<p>Пример игрового процесса:</p>

<blockquote>
  <p>ruby game.rb <br>
  Enter field size (X Y): 3 3 <br>
  Enter mines count: 2</p>
</blockquote>

<p>??? | 0!0 <br>
??? | !00 <br>
??? | 000</p>

<p>You move (X Y): 0 0 <br>
2?? <br>
??? <br>
???</p>

<p>You move (X Y): 2 2 <br>
2?? <br>
??? <br>
???</p>

<p>You move (X Y): 2 2 <br>
2?? <br>
??1 <br>
?10</p>

<p>You move (X Y): 0 2 <br>
2?? <br>
??1 <br>
110</p>

<p>You move (X Y): 0 1 <br>
2?? | 0!0 <br>
*?1 | !00 <br>
110 | 000</p>

<p>You lose. Bye!</p>
