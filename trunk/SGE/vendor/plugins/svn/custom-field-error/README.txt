custom_field_error
Michael Boutros (me@michaelboutros.com)

custom_field_error allows you to easily setup custom HTML to be displayed when there is a validation issue with a form. You can setup a different view for every model, or setup a view in one model and have that view be used as the default for all the other models. You can also explicitly override the default view you have chosen by defining another view within another model. Last but not least, you can choose to leave the Rails default view for whatever models you want.

It sounds like a lot, but it's actually very simple. Just put the following line in your model, in this case a User model:

custom_field_error "<span id='error'>?</div>"

Now, if there was an error on a field called "name" in a form, it would look like:

<span id='error'><input id="user_name" name="user[name]" size="30" type="text" value="" /></span>

However, this custom view would only be for the User view. To make this view the default view, simply set the second argument to 'default':

custom_field_error "<span id='error'>?</div>", 'default'

However, what if I now want to set a special view for my Project model? Simple. Just set custom_field_error like usual and it'll override the default view:

custom_field_error "<span id='project_error'>?</span>"

Voila! The plugin will automatically figure out what view it needs to display and display it.

Enjoy it, and feel free to shoot me an email if you're having any problems.