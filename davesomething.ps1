$file = 'C:\temp\Book1.csv'
$list = import-csv $file
$newlist = @()
ForEach ($li in $list)
{
  $number = $li.Number
  $name = $li.Name
  $x = 0
  for ($x=1; $x -le $li.Number; $x++) 
  {
  $detail = @{ Name = $li.Name }
  $newlist+= new-object  PSObject -Property $detail
  write-host $newlist.Name
  }
  $newlist | export-csv -Path 'c:\temp\fuckit.csv' -NoTypeInformation
  


}