**To Do:**

**Bugs 🐛**
  - The total mileage of that week is shown, even if the mileage for a date that hasn't happened yet isn't displayed on the dashboard. This could be easily fixed by not letting users input dates above *Today*, but that feels like cheating - I want to solve it on server side as well as client side.

**Thoughts**
  - I think it makes sense to create a week model that has a list of all the activities in that week and the mileage for the week. It's messy to try and track it all through activities. It'll be a good learning experience too.
