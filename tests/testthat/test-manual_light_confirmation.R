context("manual - ")

only_test_with_token<-function(expr){
  if(!lx_has_token()){
    skip(crayon::blue("no lifx api token in renvironment"))
    return(invisible(NULL))
  }
  expr
}

user_confirm<-function(expectation){
  user_input<-readline(prompt = paste(expectation, "?", " (enter if correct; 'n' if not)"))
  result<-FALSE
  if(user_input==""){result<-TRUE}
  expect_true(result,label = " expectation")
  # if(result){
  #   cat(
  #   crayon::green(expectation)
  #   )
  # }else{
  #   cat(crayon::red(expectation))
  #   }
  # cat("\n")
  }




only_test_with_token({
  lx_color(color_name = "red",brightness = 1,duration = 0, power = "on")
  user_confirm("bright red?")
  })

only_test_with_token({
  lx_color(power = "off")
  user_confirm("light off?")
})
  only_test_with_token({
  lx_color(color_name = "cyan", brightness = 1, duration = 3,power = "on")
  user_confirm("to cyan in 3 seconds?")
  })
  only_test_with_token({
  lx_color(brightness = 0.01,duration = 0)
  user_confirm("jump to very dim cyan?")
  })
  only_test_with_token({
  lx_color(saturation = 0,duration = 1)
  user_confirm("1 second to white?")
  })


  only_test_with_token({
  lx_color(kelvin = 2000,brightness = 1,duration = 0)
  user_confirm("immediate bright warm?")
  })
  only_test_with_token({
  lx_color(kelvin = 3000,delta = T, duration = 1)
  user_confirm("1 second to cold light?")
  })
  only_test_with_token({
  lx_effect_breathe("red","blue",period = 1,cycles = 3)
  user_confirm("breath red blue 3x?")
  })
  only_test_with_token({
  lx_color(hue = 255, saturation = 0, power = "off")
  user_confirm("lights off?")


})



