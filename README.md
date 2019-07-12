<h2>Spirits of the Forest</h2>
Two-player card game based on the physical game of the same name. 

<h3>See the live, playable version here:</h3>
http://spirits-of-the-forest-game.herokuapp.com/

<h3>PDF with game workings, database structures, data flow, and various other technical features:</h3>
https://drive.google.com/file/d/1cgSf0kZq2C_QLmAjvEJ6hDCn7A1S_7Cu/view?usp=sharing

<h3>Screencast:</h3>
https://www.youtube.com/watch?v=qZZw5Zh_8yE

<h3>To run locally:</h3>
<ul>
  <li>Download repo</li>
  <li>'bundle install' and 'yarn install' from your terminal</li>
  <li>'yarn run start' and 'rails s' from your terminal</li>
  <li>Create the database: 'bundle exec rake db:create', 'bundle exec rake db:migrate', 'bundle exec rake db:seed'</li>
  <li>Navigate your browser to localhost:3000</li>
</ul>
Note: while running locally you will need a SENDGRID_API_KEY in your .env for email features, however, these are not required to play the game.

If you download to play locally, you will still need two accounts to play against each other. To this end, once you have the server running simply open a separate instance of the application in another browser and create a second account.

<h3>Config:</h3>
<ul>
  <li>Ruby Version 2.4.5</li>
  <li>Run tests with 'bundle exec rspec' and 'yarn run test'</li>
</ul>
