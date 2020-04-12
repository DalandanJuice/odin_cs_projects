def merge_sort(arr)
  return arr if arr.length <= 1
  a = merge_sort(arr[0..(arr.length - 1)/2])
  b = merge_sort(arr[(arr.length - 1)/2 + 1..arr.length - 1])
  if a.first < b.first
    return [a.shift] + merge_sort(a + b)
  else
    return [b.shift] + merge_sort(b + a)
  end
end
