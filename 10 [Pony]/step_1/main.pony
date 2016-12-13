use "files"
use "regex"
use "collections"

class Robot
  var _values: Array[I32] = Array[I32](2)
  var _lower_receiver: (Robot | None)
  var _higher_receiver: (Robot | None)
  let _id: I32
  let _env: Env

  fun ref add_value(value: I32) =>
    perform()
    _values.push(value)
    perform()

  fun ref set_lower_receiver(robot: (Robot | None)) => _lower_receiver = robot
  fun ref set_higher_receiver(robot: (Robot | None)) => _higher_receiver = robot

  new create(id': I32, env': Env) =>
    _env = env'
    _id = id'
    _lower_receiver = None
    _higher_receiver = None


  fun ref perform() =>
    if (_values.size() == 2) and not (_lower_receiver is None) and not (_higher_receiver is None) then
      try
        var larger: I32
        var smaller: I32
        if _values(0) > _values(1) then
          larger = _values(0)
          smaller = _values(1)
        else
          larger = _values(1)
          smaller = _values(0)
        end

        if (smaller == 17) and (larger == 61) then
          _env.out.print(_id.string())
        end

        match _lower_receiver
        | let r: Robot =>
          r.add_value(smaller)
          r.perform()
        end
        match _higher_receiver
        | let r: Robot =>
          r.add_value(larger)
          r.perform()
        end
        _values.truncate(0)
      end
    end

actor Main
  var robots: HashMap[I32, Robot, HashIs[I32]] = HashMap[I32, Robot, HashIs[I32]](1)

  new create(env: Env) =>
    try
      let output = Robot(-1, env)
      let auth = env.root as AmbientAuth
      let file = File(FilePath(auth, "input.txt"))
      for line in file.lines() do
        let re_val = Regex("value (\\d+) goes to bot (\\d+)")
        if re_val == line then
          let matcher = re_val(line)
          let value: I32 = matcher(1).i32()
          let robot_num: I32 = matcher(2).i32()

          let robot: (Robot | None) = get_robot(robot_num, env)
          match robot
          | let r: Robot =>
            r.add_value(value)
            r.perform()
          end
        end

        let re_split = Regex("bot (\\d+) gives low to ([a-z]+) (\\d+) and high to ([a-z]+) (\\d+)")
        if re_split == line then
          let matcher = re_split(line)
          let bot = get_robot(matcher(1).i32(), env)
          let class_low = matcher(2)
          let low_id = matcher(3).i32()
          let class_high = matcher(4)
          let high_id = matcher(5).i32()

          match bot
          | let b: Robot =>
            if class_low == "bot" then
              let low_bot = get_robot(low_id, env)
              b.set_lower_receiver(low_bot)
            else
              b.set_lower_receiver(output)
            end

            if class_high == "bot" then
              let high_bot = get_robot(high_id, env)
              b.set_higher_receiver(high_bot)
            else
              b.set_higher_receiver(output)
            end
          end
        end

        for bot in robots.values() do
          bot.perform()
        end
      end
    end

  fun ref get_robot(num: I32, env: Env): (Robot | None) =>
    try
      if not robots.contains(num) then
        let robot = Robot(num, env)
        robots.insert(num, robot)
      end
      robots(num)
    end
