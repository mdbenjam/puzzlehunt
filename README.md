# Puzzle Hunt Server

This is a very basic puzzle hunt server with the following features:

1. Users can log in. If folks are on teams, they should share login credentials.
2. There can be multiple hunts. Each hunt can have a set of puzzles, and a score needed to win. Hunts can be active or inactive. If only one hunt is active, then users will be taken directly to that hunt's index page (with all of its available puzzles). If there are multiple active hunts, then users will get to choose which hunt they want to do.
3. Each puzzle consists of a title, an answer, a set of files, the number of points to unlock, and the number of points the user gets when solved.
4. The files in a puzzle can either be a single pdf, or an html file and associated assets (i.e. JS and CSS files).
5. Users can view each puzzle and submit answers. They will see all incorrect answers in red, and correct answers in green.
6. Answers are compared stripped of punctuation, spaces, and case insensitively.
7. There is an admin page at `/admin` where administrators can set up the hunt.
8. Users are alerted when they get enough points to win the hunt, and they are told what place they finished in.

# How to deploy the hunt

You can deploy this on whatever platform you want, but I've included a [Render blueprint file](https://render.com/docs/blueprint-spec). By clicking the button below you should be able to automatically deploy this repo on Render!

Everything should work except for file uploads. For that we use S3. You'll need to create an AWS account. Then create an S3 bucket called `puzzlehunt`. And create an IAM user with read/write access to that bucket. Get the credentials for that user and set them as environment variables in your server's render environment. The env vars should be called: `ACCESS_KEY_ID` and `SECRET_ACCESS_KEY`.

# How to create an admin user

If you followed the deploy steps above and are on the Render free tier, then there's no way to access the server your code is running on. Therefore we can't easily use the rails console to create an admin user. A simple way around this is to:

1. Go to your deployed puzzle server and sign up as a new user.
2. Open up your render console and navigate to the database. Find the connection string for making external connections.
3. Ensure `psql` is installed then copy and paste the connection string into your console and you should be connected to your DB.
4. Run `UPDATE users SET admin=true WHERE username=<YOUR USERNAME>`

# How to setup a hunt

1. Go to the `/admin` page.
2. Create a new Puzzle Hunt object.
3. Create puzzles and assign them to the puzzle hunt.
   - For each puzzle, you'll have to set the number of points a user needs to see the puzzle, and the number of points they receive when they complete a puzzle. Make sure to have some puzzles require 0 points, or else no puzzles will be visible upon starting.
   - Upload content files for each puzzle. You can either upload a single pdf file or an html file (called index.html) and any associated js/css files. These files don't need to be zipped, you can just upload multiple files via the file uploader. The html file should reference any files it needs to load at the root level. For example if you upload `index.html` and `script.js` then `index.html` should contain this line ` <script src="./script.js"></script>`.
4. You'll need to set the puzzle hunt object to active for users to see it.
