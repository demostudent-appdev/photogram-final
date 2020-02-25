# Photogram Final

Look around [the target](http://photogram-final.matchthetarget.com/) and try to identify the new things, as compared to Photogram Signin.

## Tasks to accomplish

###### Before anything, a User must be able to sign in with an Email and Password at `/user_sign_in`

- There is a Users index page (`/users`)
  - it lists the usernames of each user.

- There is a User show page (`/users/[username]`)
  - it displays the username of the user.

  - it displays the usernames of the User's who's follow requests are pending.

  - it displays the captions of each of the photos that the user has posted.

  -  it displays "Delete this photo" button when photo belongs to current user.

- The Photo show page (`/photos/[id]`)
  - it displays "Delete this photo" button when the photo belongs to current user.

  - it displays a form to Update the photo when the photo belongs to current user.

  - it has a form to like the photo and automatically populates the `fan_id` and `photo_id` column to be the id of the signed in user and the id of the photo.

  - it has a link to remove a like from a Photo.

  - it has a form to add comments and automatically associates a comment with the signed in user and current photo.

- There is a feed page (`/users/[username]/feed`)
  - it lists the photos posted by the people the user is following.

- There is a liked photos page (`/users/[username]/liked_photos`)
  - it lists the photos that are liked by the current signed in user.

- There is a discover page (`/users/[username]/discover`)
  - it lists the photos that are liked by the people the user is following


rails g draft:resource photo owner_id:integer caption:text likes_count:integer comments_count:integer image:string
rails g draft:resource photo caption:text image:string owner_id:integer comments_count:integer likes_count:integer