test_that("Incorrectly Formatted Inputs Throw an Error", {
          expect_error(viewCityMap("Florence", "AZ"))                       # Abbreviated state
          expect_error(viewCityMap("NYC", "New York"))                      # Abbreviated city
          expect_error(viewCityMap(Boston, "Massachusetts"))                # City not a string
          expect_error(viewCityMap("Orlando", Florida))                     # State not a string
          expect_error(viewCityMap("Chicago", "Iowa"))                      # Mismatched city and state
          expect_error(viewCityMap("Fairytale", "Utah"))                    # City not in list
          expect_error(viewCityMap("Seattle", "Sweden"))                    # State not in list
          expect_error(viewCityMap("Los Angeles", "California", toner))     # Map type not a string
          expect_error(viewCityMap("Los Angeles", "California", "google"))  # Map type not in list
          })

test_that("Function Successfully Connects to Stamen Maps", {
          expect_message(viewCityMap("Phoenix", "Arizona"), 
                         "Map tiles by Stamen Design, under CC BY 3.0. Data by OpenStreetMap, under ODbL.")
          })