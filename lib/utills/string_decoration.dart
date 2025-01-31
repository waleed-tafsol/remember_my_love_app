String capitalizeFirstLetter(String input) {
  if (input.isEmpty) return input; // Return the input if it's empty
  return input[0].toUpperCase() + input.substring(1);
}