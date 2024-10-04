String expressionFormatToShow(String expression) {
  return expression.replaceAll('*', 'x').replaceAll('/', '÷');
}

String expressionFormatToConsole(String expression) {
  return expression.replaceAll('x', '*').replaceAll('÷', '/');
}
