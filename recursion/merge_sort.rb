def merge_sort(arr)
  return arr if arr.length <= 1
  a = alternative_merge(arr[0..(arr.length - 1)/2])
  b = alternative_merge(arr[(arr.length - 1)/2 + 1..arr.length - 1])
  if a.first < b.first
    merge = [a.shift]
    return merge + alternative_merge(a + b)
  end
    merge = [b.shift]
    return merge + alternative_merge(b + a)
end
