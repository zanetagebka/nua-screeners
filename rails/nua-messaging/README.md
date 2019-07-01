Please find attached a repo containing a Rails application. The application currently just displays a message which a patient has received after applying for a treatment.

The application comes packaged with the following models:

* User
* Message
* Inbox
* Outbox
* Payment

When a user sends a message, it goes into their outbox and into the inbox of the recipient.

### Get up & running

Running `rails db:seed` will:

- Create a patient, admin and doctor user
- Create an inbox and outbox for each of the created users
- Create a message from a doctor to a patient, which thanks them for applying for a treatment

Run the server using `rails s`

### Task 1

Patients should have the ability to send a message to their doctor through the app.

However, a message should only be sent to a doctor if the original message was created in the past week.
If the original message was created more than a week ago then the message should be routed to an Admin.

After submitting the form, the application should:

1. Create a new message, marked as unread
2. Update the senders outbox
3. Update the recipients inbox

Notes:

1. You can assume there will only be one doctor in the DB.
2. You don't need to worry about sessions or security. You can call User.current to return the only patient in the system.
3. Your design should assume that a doctor will have hungreds of thousands of messages in their inbox.
 

### Task 2

Doctors have requested the ability to quickly see how many unread messages they have in their inbox. Add a new column to Inbox that reflects this number. Update this number when a message has been sent to the doctor.

### Task 3

Patients regularly lose their prescription notes. An admin can re-issue a prescription note on behalf of a doctor. Update the application as follows:

1. When the patient clicks the "I've lost my script, please issue a new one at a charge of €10" button, it should send a hardcoded message to an admin requesting a new script
2. An API request to our Payment Provider should be called (this simply involves calling PaymentProviderFactory.provider.debit_card(patient_user))
3. A new Payment record should be created
