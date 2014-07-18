function fish_title
  echo -n (prompt_pwd)
  if test $_ != "fish"
    echo -n " " $_
  end
end
