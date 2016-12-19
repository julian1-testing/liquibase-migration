

BEGIN {
  # RS=";|\n"
}
{
  switch ($0) {
    
    # ignore echo commands,
    case /\\echo/:
      break

    default:
      print $0
  }
}


