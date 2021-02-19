

This is a sample application that checks a googgle spreadsheet and checks for new entries. New entries representing a candidates information will be contacted by email or phone. Candidates are contacted through Talkpush's api. 

### Google sheet setup

Download Google's credentials and copy them to this project with the filename `client_secret.json`.


## Running the application

Run `bundle install` in the general folder.

Install dependencies
`bundle install google_drive`

Change the APIkey and the APIsecret as needed.

The app checks for new entries in two ways.

##### First way:

* Run `bundle exec ruby button_check.rb` in the root folder.
* Check http://localhost:4567/ 
* Read the information displayed.
* Click submit after entering a candidate's information in the google spreadsheet provided.
* Check the results by receiving a call or email from the information provided.

##### Second way:

* Run `bundle exec ruby interval_check.rb` in the root folder
* Add entries to https://docs.google.com/spreadsheets/d/1xkofJa5iI3AQE4yWEoHqMTQ1QQ-VDsfUDDwV96QQDVM/edit?usp=sharing .
* The spreadsheet is checked every 5 seconds.
* Check the results by receiving a call or email from the information provided.


### How it works

Two spreadsheets are linked. Anytime a new entry is made in the original spreadsheet https://docs.google.com/spreadsheets/d/1xkofJa5iI3AQE4yWEoHqMTQ1QQ-VDsfUDDwV96QQDVM/edit?usp=sharing , they will be added to a second spreadsheet so then entries can be compared, and then an API call is made to Talkpush's API with the candidate's information.
