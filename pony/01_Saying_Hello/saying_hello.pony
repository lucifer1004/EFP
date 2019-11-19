actor Main
  new create(env: Env) =>
    env.out.write("What is your name? ")

    var input = recover iso MyInput.create(env) end
    env.input(consume input)

class MyInput is InputNotify
  var _env: Env
  var _buffer: Array[U8] iso

  new create(env: Env) =>
    _env = env
    _buffer = recover iso Array[U8].create() end

  fun ref apply(data: Array[U8] iso) =>
    for item in (consume data).values() do
      if item == 0x0A then
        _env.out.print("")
        _env.out.write("Hello, ")
        let bufferOutIso = _buffer = recover iso Array[U8].create() end
        _env.out.write(consume bufferOutIso)
        _env.out.write(", nice to meet you!")
        _env.input.dispose()
      else
        _env.out.write(String.from_array([item]))
        _buffer.push(item)
      end
    end

  fun ref dispose() => None