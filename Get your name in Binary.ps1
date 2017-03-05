function Get-NameInBinary {
    param(
        [parameter(DontShow)] # hide paramter to allow read host to promt for name(s)
        [string]$name = $(read-host -Prompt "Enter Name(s)")
    )

    # Pass name from function to screen
    "Your Name '{0}' in Binary is : " -f $name

    # get the value of whitespace in binary to seperate names, surnames or middle names
    $whiteSpace = ([byte][char]' ') | % { [System.Convert]::ToString($_,2).PadLeft(8,'0') }

     $output = <# Capture each letter in Binary #>
         # pass the variable name to a foreach loop
         # using a for statement start a counter at zero and stop and the given Length of characters in variable $name
              $name | %{ for($i=0;$i -lt $name.Length;$i++) {
                    # split name by each 'for' count in variable $i to char number
                    [int][char]$_[$i] | %{
                        # pass the string and the number base
                        # (which is base 2 for the case of binary number conversion)
                        # 'PadLeft' adds a 0 to the front of the number to represent a binary string value
                        [System.Convert]::ToString($_,2).PadLeft(8,'0')
                    }
                }
             }
    # Attach each Binary "letter" to array
    [array]$outputs += $output
    # Display the name in Binary and join all values together, finding the whitespace value for any
    # names supplied with a middle or surname and add replace the Binary value of a whitespace with a space
    ($outputs -join '').Replace($whiteSpace, ' ')
}