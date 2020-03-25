def fibs(num)
  i = 0
  a = 1
  arr = []
  while arr.length < num
    arr.push(i)
    arr.push(a) if arr.length < num
    i = i + a
    a = i + a
  end
  arr
end

def fibs_rec(num,result=[])
  return [0] if num == 1
  return [0,1] if num == 2
  return fibs_rec(num - 1) + [fibs_rec(num - 1)[-2] + fibs_rec(num - 1)[-1]]
end



