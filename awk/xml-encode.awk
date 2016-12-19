
BEGIN {
  RS=";"
  ORS=";"
  count = 0
}
{
  split($0, chars, "")
  for (i=1; i <= length($0); i++) {
    #printf("%s", chars[i])
    ch = chars[i]

    switch (ch) {

      # our quoting strategy doesn't quite work, because we have ampersands that are in dynamic
      # sql...
#      case /'/:
#        ++count
#        printf("%s", ch)
#        break
        
      case /</:
        if(count % 2 == 0) 
          printf("&lt;")
        else
          printf("%s", ch)
        break

      case />/:
      if(count % 2 == 0) 
          printf("&gt;")
        else
          printf("%s", ch)
        break


      case /&/:
      if(count % 2 == 0) 
          printf("&amp;")
        else
          printf("%s", ch)
        break


      default:
        printf("%s", ch)
        break
    }
  }
}


 

# ok, read each statement, and then match / switch....
# it is printing the substitution in entirely the wrong place, 
# otherwise we want to print anything else....
# I think we may need a case/switch statement...


