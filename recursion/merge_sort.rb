def merge_sort(arr)
  return arr if arr.length <= 1
  a = alternative_merge(arr[0..(arr.length - 1)/2])
  b = alternative_merge(arr[(arr.length - 1)/2 + 1..arr.length - 1])
  if a.first < b.first
    return [a.shift] + alternative_merge(a + b)
  end
    return [b.shift] + alternative_merge(b + a)
end
puts merge_sort([8,2,6,1,5,3,7,4]).to_s
