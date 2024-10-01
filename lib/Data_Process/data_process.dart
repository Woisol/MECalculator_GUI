String expressionFormat(String expression) {
  return expression.replaceAll('*', 'x').replaceAll('/', '÷');
}
