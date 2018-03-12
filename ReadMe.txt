Coding challenge:

The app is using custom NetworkClient in order to capture and treat accordingly any error.
The TimeBar component is using UIBezierPath components for the drawings.
The app is implemented in the MVVM way.

Due to the suggested time limit (between 5 and 10 hours) it was difficult to achieve all the goals leading to the current state of the app:

	there’s only one filter in Search screen (filtering by 'name')
	room booking screen is not implemented

The reasons behind the decision of skipping those parts are:

	the availability filter is quite similar to the one implemented, but it will take some additional time in order to validate all the time frames with the proper time zone (Europe/Berlin)
	the booking component setup (Endpoint, Client and ViewModel) is similar to the one impemented for Search; the main time consuming parts are:

		selection of the valid time frames with UIDatePicker (easier solution) or dragging (more elegant solution, at least on big screen devices)
		insertion and validation of attendees (their emails and phone numbers in particular)

Please let me know if yoe want me to continue implementing the remaining features (it will take half a day more or less) or the current state of the app is enough for the evaluation purposes.
Much appreciated in advance.
