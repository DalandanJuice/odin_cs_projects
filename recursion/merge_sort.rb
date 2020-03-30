def merge_sort(arr)
  return arr if arr.length <= 1
  a = merge_sort(arr[0..(arr.length - 1)/2])
  b = merge_sort(arr[(arr.length - 1)/2 + 1..arr.length - 1])
  if a.first < b.first
    merge = [a.shift]
    return merge + merge_sort(a + b)
  end
    merge = [b.shift]
    return merge + merge_sort(b + a)
end
