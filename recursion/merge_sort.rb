def merge_sort(arr)
  return arr if arr.length <= 1
  a = merge_sort(arr[0..(arr.length - 1)/2])
  b = merge_sort(arr[(arr.length - 1)/2 + 1..arr.length - 1])
  if a.first < b.first
<<<<<<< HEAD
    return [a.shift] + alternative_merge(a + b)
  end
    return [b.shift] + alternative_merge(b + a)
=======
    return a.shift + merge_sort(a + b)
  end
    return b.shift + merge_sort(b + a)
>>>>>>> refs/remotes/origin/master
end
puts merge_sort([8,2,6,1,5,3,7,4]).to_s
