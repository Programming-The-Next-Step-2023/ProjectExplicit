/* create timeline */
var timeline = [];

// timeline.push();

// Last change 22:47
lightnessVal = 2;
document.body.style.backgroundColor = "hsl(0,0%,"+lightnessVal+"%)";
document.body.style.color = "white";
document.body.style.fontSize = "25px";

var adaptive_trial_duration = 1230
var subject_id = jsPsych.randomization.randomID(10);

jsPsych.data.addProperties({
	  uniqueSubID: subject_id
});

var green_rgb = '0, 128, 0'
var red_rgb = '255, 0, 0'
var blue_rgb = '0, 0, 255'

// these are in HTML, so <br> means "line break"
var opening_screen = {
    type: 'instructions',
    pages: [
      "<p style='color: white'> Welcome to the task!<br><br> For this task, you need sound. <br> <br> In the next screen, a beep will play. Please turn up your sound so that you can clearly hear this beep. <br><br><br> Press the Spacebar to continue.",
      ],
    key_forward: ' '
}

var fix_audio = {
  timeline: [{
          type: 'audio-button-response',
          stimulus: 'sound/beep2.wav',
          prompt: "Can you hear the beep? <br><br> Press Continue if you can clearly hear the beep",
          choices: ['Play again','Continue'],
}],
  loop_function: function(data){
      if(data.values()[0].button_pressed == 0){
          return true;
      } else {
          return false;
      }
  }
}

var fullscreen_trial  = {
	type: 'fullscreen',
  	fullscreen_mode: true,
  	message: '<p>The experiment will switch to full screen mode when you press the button below <br><br><br></p>'
};

var cursor_off = {
  type: 'call-function',
  func: function() {
      document.body.style.cursor= "none";
  }
}

var cursor_on = {
  type: 'call-function',
  func: function() {
      document.body.style.cursor= "auto";
  }
}

var first_instructions = {
    type: 'instructions',
    pages: [
      "In this experiment, you will need to press the keys <b>R, G and B</b> on your keyboard. <br>" +
      "Please place your ring-, middle- and index finger on these keys (see example below). <br><br>" +
          "<img src='img/finger_placement.jpg' style: width = 400px></img>" +
          "<p class='small'><br>Press the Spacebar to continue.",
      "Next, you will see the letter X in a certain colour. <br> Your task is to indicate which colour" +
      " the X's are by pressing the first letter of this colour on the keyboard. <br><br> If the <p style= 'color: rgb("+red_rgb+"); display:inline'>X</p>'s are" +
      " coloured red, press the R key (R for Red). <br> If the <p style= 'color: rgb("+green_rgb+"); display:inline'>X</p>'s are" +
      " coloured green, press the G key (G for Green). <br> If the <p style= 'color: rgb("+blue_rgb+"); display:inline'>X</p>'s are" +
      " coloured blue, press the B key (B for Blue) <br><br>" +
      "Press the Spacebar to start a few practice trials."
      ],
    key_forward: ' '
}

var xxx_practice_block = {
    timeline: [
        {
            type: 'html-keyboard-response',
            stimulus: '<p style= "font-weight: bold; font-size: 35px"> * * * * *',
            choices: jsPsych.NO_KEYS,
            trial_duration: jsPsych.timelineVariable("ITI_duration"),
            data: {ITI: jsPsych.timelineVariable("ITI_duration")}
        },
        {
            type: 'html-keyboard-response',
            //response_ends_trial: true,
            stimulus: function () {
                // note: the outer parentheses are only here so we can break the line
                return (
                     '<p style= "font-weight: bold; font-size: 35px; color: '+jsPsych.timelineVariable("colour", true)+'">'
                     +jsPsych.timelineVariable("text", true)
                     +'</p>'
                );
            },
            // 'choices' restricts the available responses for the participant
            choices: ['r','g','b'],
            //trial_duration: function () {
            //  return adaptive_trial_duration
            //},
            data: {
              colour: jsPsych.timelineVariable('colour'),
              text: jsPsych.timelineVariable('text'),
              condition: jsPsych.timelineVariable('condition'),
              correct_response: jsPsych.timelineVariable('correct_response'),
              test_part: jsPsych.timelineVariable('test_part'),
              adaptive_window: function (){
              return adaptive_trial_duration}
            },
            on_finish: function(data){
              if (data.key_press){
              data.correct = data.key_press == jsPsych.pluginAPI.convertKeyCharacterToKeyCode(data.correct_response); }
              else { data.correct = 'no_response'}
            }
        },
        {
          type: 'html-keyboard-response',
          stimulus: function () {
            if (jsPsych.data.get().last(1).filter({correct: true}).count() == 1){
              var cor_or_not = '<p style= "font-weight: bold; font-size: 35px; color: white">' + 'Correct!' +'</p>'
            } else {
              var cor_or_not = '<p style= "font-weight: bold; font-size: 35px; color: white">' + 'Incorrect!' +'</p>'
            }
            return (cor_or_not)},
          trial_duration: 1000,
          choices: jsPsych.NO_KEYS
        }

    ],
    timeline_variables: [
    {test_part: 'xxx_practice', colour: 'rgb('+blue_rgb+')', text: "xxxx", condition: "x_congruent", correct_response: 'B', ITI_duration: jsPsych.randomization.sampleWithReplacement([400,420,440,460,480,500,520,540,560,580,600,620,640,660,680,700], 1)},
    {test_part: 'xxx_practice', colour: 'rgb('+red_rgb+')', text: "xxx", condition: "x_congruent", correct_response: 'R', ITI_duration: jsPsych.randomization.sampleWithReplacement([400,420,440,460,480,500,520,540,560,580,600,620,640,660,680,700], 1)},
    {test_part: 'xxx_practice', colour: 'rgb('+green_rgb+')', text: "xxxxx", condition: "x_congruent", correct_response: 'G', ITI_duration: jsPsych.randomization.sampleWithReplacement([400,420,440,460,480,500,520,540,560,580,600,620,640,660,680,700], 1)},
    {test_part: 'xxx_practice', colour: 'rgb('+blue_rgb+')', text: "xxxxx", condition: "x_incongruent", correct_response: 'B', ITI_duration: jsPsych.randomization.sampleWithReplacement([400,420,440,460,480,500,520,540,560,580,600,620,640,660,680,700], 1)},
    {test_part: 'xxx_practice', colour: 'rgb('+blue_rgb+')', text: "xxx", condition: "x_incongruent", correct_response: 'B', ITI_duration: jsPsych.randomization.sampleWithReplacement([400,420,440,460,480,500,520,540,560,580,600,620,640,660,680,700], 1)},
    {test_part: 'xxx_practice', colour: 'rgb('+green_rgb+')', text: "xxxx", condition: "x_incongruent", correct_response: 'G', ITI_duration: jsPsych.randomization.sampleWithReplacement([400,420,440,460,480,500,520,540,560,580,600,620,640,660,680,700], 1)},
    {test_part: 'xxx_practice', colour: 'rgb('+green_rgb+')', text: "xxx", condition: "x_incongruent", correct_response: 'G', ITI_duration: jsPsych.randomization.sampleWithReplacement([400,420,440,460,480,500,520,540,560,580,600,620,640,660,680,700], 1)},
    {test_part: 'xxx_practice', colour: 'rgb('+red_rgb+')', text: "xxxx", condition: "x_incongruent", correct_response: 'R', ITI_duration: jsPsych.randomization.sampleWithReplacement([400,420,440,460,480,500,520,540,560,580,600,620,640,660,680,700], 1)},
    {test_part: 'xxx_practice', colour: 'rgb('+red_rgb+')', text: "xxxxx", condition: "x_incongruent", correct_response: 'R', ITI_duration: jsPsych.randomization.sampleWithReplacement([400,420,440,460,480,500,520,540,560,580,600,620,640,660,680,700], 1)},
    ],
    sample: {
        type: 'custom',
        fn: function(t){
          // first sample 12 congruent and 6 congruent trials (with replacement)
          t_congruent = jsPsych.randomization.sampleWithReplacement([0,1,2], 3)
          t_incongruent = jsPsych.randomization.sampleWithReplacement([3,4,5,6,7,8], 3)
          t_unshuffled = t_congruent.concat(t_incongruent)
          // then shuffle their order
          t = jsPsych.randomization.sampleWithoutReplacement(t_unshuffled, 6)

          return t; //
        }
    }
}

var second_instructions = {
    type: 'instructions',
    pages: [
      "Great! <br><br> Now the X's will be replaced by words. <br>" +
      "The words may confuse you. Just try to ignore them and focus on the colour.<br>" +
      "Keep your eyes on the middle of the screen at the word" +
      "<br>Respond as fast and accurate as possible. <br><br> Press the Spacebar to continue.",
      ],
    key_forward: ' '
}


var untimed_normal_practice_block = {
    timeline: [
        {
            type: 'html-keyboard-response',
            stimulus: '<p style= "font-weight: bold; font-size: 35px"> * * * * *',
            choices: jsPsych.NO_KEYS,
            trial_duration: jsPsych.timelineVariable("ITI_duration"),
            data: {ITI: jsPsych.timelineVariable("ITI_duration")}
        },
        {
            type: 'html-keyboard-response',
            //response_ends_trial: true,
            stimulus: function () {
                // note: the outer parentheses are only here so we can break the line
                return (
                     '<p style= "font-weight: bold; font-size: 35px; color: '+jsPsych.timelineVariable("colour", true)+'">'
                     +jsPsych.timelineVariable("text", true)
                     +'</p>'
                );
            },
            // 'choices' restricts the available responses for the participant
            choices: ['r','g','b'],
            //trial_duration: function () {
            //  return adaptive_trial_duration
            //},
            data: {
              colour: jsPsych.timelineVariable('colour'),
              text: jsPsych.timelineVariable('text'),
              condition: jsPsych.timelineVariable('condition'),
              correct_response: jsPsych.timelineVariable('correct_response'),
              test_part: jsPsych.timelineVariable('test_part'),
              adaptive_window: function (){
              return adaptive_trial_duration}
            },
            on_finish: function(data){
              if (data.key_press){
              data.correct = data.key_press == jsPsych.pluginAPI.convertKeyCharacterToKeyCode(data.correct_response); }
              else { data.correct = 'no_response'}
            }
        },
        {
          type: 'html-keyboard-response',
          stimulus: function () {
            if (jsPsych.data.get().last(1).filter({correct: true}).count() == 1){
              var cor_or_not = '<p style= "font-weight: bold; font-size: 35px; color: white">' + 'Correct!' +'</p>'
            } else {
              var cor_or_not = '<p style= "font-weight: bold; font-size: 35px; color: white">' + 'Incorrect!' +'</p>'
            }
            return (cor_or_not)},
          trial_duration: 1000,
          choices: jsPsych.NO_KEYS
        }

    ],
    timeline_variables: [
    {test_part: 'xxx_normal_practice', colour: 'rgb('+blue_rgb+')', text: "BLUE", condition: "congruent", correct_response: 'B', ITI_duration: jsPsych.randomization.sampleWithReplacement([400,420,440,460,480,500,520,540,560,580,600,620,640,660,680,700], 1)},
    {test_part: 'xxx_normal_practice', colour: 'rgb('+red_rgb+')', text: "RED", condition: "congruent", correct_response: 'R', ITI_duration: jsPsych.randomization.sampleWithReplacement([400,420,440,460,480,500,520,540,560,580,600,620,640,660,680,700], 1)},
    {test_part: 'xxx_normal_practice', colour: 'rgb('+green_rgb+')', text: "GREEN", condition: "congruent", correct_response: 'G', ITI_duration: jsPsych.randomization.sampleWithReplacement([400,420,440,460,480,500,520,540,560,580,600,620,640,660,680,700], 1)},
    {test_part: 'xxx_normal_practice', colour: 'rgb('+blue_rgb+')', text: "GREEN", condition: "incongruent", correct_response: 'B', ITI_duration: jsPsych.randomization.sampleWithReplacement([400,420,440,460,480,500,520,540,560,580,600,620,640,660,680,700], 1)},
    {test_part: 'xxx_normal_practice', colour: 'rgb('+blue_rgb+')', text: "RED", condition: "incongruent", correct_response: 'B', ITI_duration: jsPsych.randomization.sampleWithReplacement([400,420,440,460,480,500,520,540,560,580,600,620,640,660,680,700], 1)},
    {test_part: 'xxx_normal_practice', colour: 'rgb('+green_rgb+')', text: "BLUE", condition: "incongruent", correct_response: 'G', ITI_duration: jsPsych.randomization.sampleWithReplacement([400,420,440,460,480,500,520,540,560,580,600,620,640,660,680,700], 1)},
    {test_part: 'xxx_normal_practice', colour: 'rgb('+green_rgb+')', text: "RED", condition: "incongruent", correct_response: 'G', ITI_duration: jsPsych.randomization.sampleWithReplacement([400,420,440,460,480,500,520,540,560,580,600,620,640,660,680,700], 1)},
    {test_part: 'xxx_normal_practice', colour: 'rgb('+red_rgb+')', text: "BLUE", condition: "incongruent", correct_response: 'R', ITI_duration: jsPsych.randomization.sampleWithReplacement([400,420,440,460,480,500,520,540,560,580,600,620,640,660,680,700], 1)},
    {test_part: 'xxx_normal_practice', colour: 'rgb('+red_rgb+')', text: "GREEN", condition: "incongruent", correct_response: 'R', ITI_duration: jsPsych.randomization.sampleWithReplacement([400,420,440,460,480,500,520,540,560,580,600,620,640,660,680,700], 1)},
    ],
    sample: {
        type: 'custom',
        fn: function(t){
          // first sample 12 congruent and 6 congruent trials (with replacement)
          t_congruent = jsPsych.randomization.sampleWithReplacement([0,1,2], 12)
          t_incongruent = jsPsych.randomization.sampleWithReplacement([3,4,5,6,7,8], 6)
          t_unshuffled = t_congruent.concat(t_incongruent)
          // then shuffle their order
          t = jsPsych.randomization.sampleWithoutReplacement(t_unshuffled, 18)

          return t; //
        }
    }
}

var third_instructions = {
    type: 'instructions',
    pages: [
      "From now on, you need to be as fast as possible WITHOUT MAKING MISTAKES <br>" +
      "However, you will not receive feedback for correct responses anymore. <br>" +
      "If you do not respond quick enough, you will HEAR A BEEP <br>" +
      "If you hear the beep, it means to go faster next time! <br>" +
      "<br> <br> Please press the Spacebar to continue with more practice trials"
      ],
    key_forward: ' '
}

var incorrect_message = {
          // NOT CORRECT YET! SHOULD ONLY BE DONE IF PARTICIPANT IS TOO SLOW
          type: 'audio-keyboard-response',
          stimulus: 'sound/beep.wav',
          choices: jsPsych.NO_KEYS,
          trial_duration: 1000,
          prompt: "<p style= 'font-weight: bold; font-size: 35px'> TOO SLOW! <br> GO FASTER!",
}

var incorrect_message_node = {
  timeline: [incorrect_message],
  conditional_function: function(){
    if(jsPsych.data.get().last(1).filter({correct: 'no_response'}).count() == 1){
      return true;
      } else {
      return false;
      }
  }
}

var normal_practice_block = {
    timeline: [
        {
            type: 'html-keyboard-response',
            stimulus: '<p style= "font-weight: bold; font-size: 35px"> * * * * *',
            choices: jsPsych.NO_KEYS,
            trial_duration: jsPsych.timelineVariable("ITI_duration"),
            data: {ITI: jsPsych.timelineVariable("ITI_duration")}
        },
        {
            type: 'html-keyboard-response',
            //stimulus: function () {return(jsPsych.data.get().filter({test_part: 'normal_practice'}).count())},
            //response_ends_trial: true,
            stimulus: function () {
                // note: the outer parentheses are only here so we can break the line
                return (
                     '<p style= "font-weight: bold; font-size: 35px; color: '+jsPsych.timelineVariable("colour", true)+'">'
                     +jsPsych.timelineVariable("text", true)
                     +'</p>'
                );
            },
            // 'choices' restricts the available responses for the participant
            choices: ['r','g','b'],
            trial_duration: function(){
              n_practice_trials = jsPsych.data.get().filter({test_part: 'normal_practice'}).count()
              if (n_practice_trials == 0){
                return 3300;
              } else if (n_practice_trials == 1 || n_practice_trials == 2) {
                return 2400
              } else if (n_practice_trials > 2 && n_practice_trials < 6) {
                return 1900
              } else if (n_practice_trials == 6 || n_practice_trials == 7 || n_practice_trials == 8) {
                return 1700
              } else if (n_practice_trials == 9 || n_practice_trials == 10) {
                return 1500
              } else if (n_practice_trials == 11) {
                return 1400
              } else if (n_practice_trials > 11) {
                return 1300
              }
            }
            ,
            data: {
              colour: jsPsych.timelineVariable('colour'),
              text: jsPsych.timelineVariable('text'),
              condition: jsPsych.timelineVariable('condition'),
              correct_response: jsPsych.timelineVariable('correct_response'),
              test_part: jsPsych.timelineVariable('test_part'),
              adaptive_window: function (){
              return adaptive_trial_duration}
            },
            on_finish: function(data){
              if (data.key_press){
              data.correct = data.key_press == jsPsych.pluginAPI.convertKeyCharacterToKeyCode(data.correct_response); }
              else { data.correct = 'no_response'}
            }
        },
        incorrect_message_node,
    ],
    timeline_variables: [
    {test_part: 'normal_practice', colour: 'rgb('+blue_rgb+')', text: "BLUE", condition: "congruent", correct_response: 'B', ITI_duration: jsPsych.randomization.sampleWithReplacement([400,420,440,460,480,500,520,540,560,580,600,620,640,660,680,700], 1)},
    {test_part: 'normal_practice', colour: 'rgb('+red_rgb+')', text: "RED", condition: "congruent", correct_response: 'R', ITI_duration: jsPsych.randomization.sampleWithReplacement([400,420,440,460,480,500,520,540,560,580,600,620,640,660,680,700], 1)},
    {test_part: 'normal_practice', colour: 'rgb('+green_rgb+')', text: "GREEN", condition: "congruent", correct_response: 'G', ITI_duration: jsPsych.randomization.sampleWithReplacement([400,420,440,460,480,500,520,540,560,580,600,620,640,660,680,700], 1)},
    {test_part: 'normal_practice', colour: 'rgb('+blue_rgb+')', text: "GREEN", condition: "incongruent", correct_response: 'B', ITI_duration: jsPsych.randomization.sampleWithReplacement([400,420,440,460,480,500,520,540,560,580,600,620,640,660,680,700], 1)},
    {test_part: 'normal_practice', colour: 'rgb('+blue_rgb+')', text: "RED", condition: "incongruent", correct_response: 'B', ITI_duration: jsPsych.randomization.sampleWithReplacement([400,420,440,460,480,500,520,540,560,580,600,620,640,660,680,700], 1)},
    {test_part: 'normal_practice', colour: 'rgb('+green_rgb+')', text: "BLUE", condition: "incongruent", correct_response: 'G', ITI_duration: jsPsych.randomization.sampleWithReplacement([400,420,440,460,480,500,520,540,560,580,600,620,640,660,680,700], 1)},
    {test_part: 'normal_practice', colour: 'rgb('+green_rgb+')', text: "RED", condition: "incongruent", correct_response: 'G', ITI_duration: jsPsych.randomization.sampleWithReplacement([400,420,440,460,480,500,520,540,560,580,600,620,640,660,680,700], 1)},
    {test_part: 'normal_practice', colour: 'rgb('+red_rgb+')', text: "BLUE", condition: "incongruent", correct_response: 'R', ITI_duration: jsPsych.randomization.sampleWithReplacement([400,420,440,460,480,500,520,540,560,580,600,620,640,660,680,700], 1)},
    {test_part: 'normal_practice', colour: 'rgb('+red_rgb+')', text: "GREEN", condition: "incongruent", correct_response: 'R', ITI_duration: jsPsych.randomization.sampleWithReplacement([400,420,440,460,480,500,520,540,560,580,600,620,640,660,680,700], 1)},
    ],
    sample: {
        type: 'custom',
        fn: function(t){
          // first sample 12 congruent and 6 congruent trials (with replacement)
          t_congruent = jsPsych.randomization.sampleWithReplacement([0,1,2], 12)
          t_incongruent = jsPsych.randomization.sampleWithReplacement([3,4,5,6,7,8], 6)
          t_unshuffled = t_congruent.concat(t_incongruent)
          // then shuffle their order
          t = jsPsych.randomization.sampleWithoutReplacement(t_unshuffled, 18)
          return t; //
        }
    }
}

var fourth_instructions = {
    type: 'instructions',
    pages: [
      "END OF PRACTICE <br>" +
      "The real trials of the task are about to begin <br>" +
      "The task will become harder if you perform the task well <br>"+
      "The task will become easier if you do not perform well <br>" +
      "Try to do your best! <br><br> REMEMBER: Be as accurate as possible. But respond BEFORE the beep. <br><br> Press the Space bar when you are ready to start the real trials"
      ],
    key_forward: ' '
}

var trial_block = {
    timeline: [
        {
            type: 'html-keyboard-response',
            stimulus: '<p style= "font-weight: bold; font-size: 35px"> * * * * *',
            choices: jsPsych.NO_KEYS,
            trial_duration: jsPsych.timelineVariable("ITI_duration"),
            data: {ITI: jsPsych.timelineVariable("ITI_duration")}
        },
        {
            type: 'html-keyboard-response',
            //response_ends_trial: true,
            stimulus: function () {
                // note: the outer parentheses are only here so we can break the line
                return (
                     '<p style= "font-weight: bold; font-size: 35px; color: '+jsPsych.timelineVariable("colour", true)+'">'
                     +jsPsych.timelineVariable("text", true)
                     +'</p>'
                );
            },
            // 'choices' restricts the available responses for the participant
            choices: ['r','g','b'],
            trial_duration: function () {
              return adaptive_trial_duration
            },
            data: {
              colour: jsPsych.timelineVariable('colour'),
              text: jsPsych.timelineVariable('text'),
              condition: jsPsych.timelineVariable('condition'),
              correct_response: jsPsych.timelineVariable('correct_response'),
              test_part: jsPsych.timelineVariable('test_part'),
              adaptive_window: function (){
              return adaptive_trial_duration}
            },
            on_finish: function(data){
              if (data.key_press){
              data.correct = data.key_press == jsPsych.pluginAPI.convertKeyCharacterToKeyCode(data.correct_response); }
              else { data.correct = 'no_response'}
            }
        },
        incorrect_message_node,
    ],
    timeline_variables: [
    {test_part: 'test', colour: 'rgb('+blue_rgb+')', text: "BLUE", condition: "congruent", correct_response: 'B', ITI_duration: jsPsych.randomization.sampleWithReplacement([400,420,440,460,480,500,520,540,560,580,600,620,640,660,680,700], 1)},
    {test_part: 'test', colour: 'rgb('+red_rgb+')', text: "RED", condition: "congruent", correct_response: 'R', ITI_duration: jsPsych.randomization.sampleWithReplacement([400,420,440,460,480,500,520,540,560,580,600,620,640,660,680,700], 1)},
    {test_part: 'test', colour: 'rgb('+green_rgb+')', text: "GREEN", condition: "congruent", correct_response: 'G', ITI_duration: jsPsych.randomization.sampleWithReplacement([400,420,440,460,480,500,520,540,560,580,600,620,640,660,680,700], 1)},
    {test_part: 'test', colour: 'rgb('+blue_rgb+')', text: "GREEN", condition: "incongruent", correct_response: 'B', ITI_duration: jsPsych.randomization.sampleWithReplacement([400,420,440,460,480,500,520,540,560,580,600,620,640,660,680,700], 1)},
    {test_part: 'test', colour: 'rgb('+blue_rgb+')', text: "RED", condition: "incongruent", correct_response: 'B', ITI_duration: jsPsych.randomization.sampleWithReplacement([400,420,440,460,480,500,520,540,560,580,600,620,640,660,680,700], 1)},
    {test_part: 'test', colour: 'rgb('+green_rgb+')', text: "BLUE", condition: "incongruent", correct_response: 'G', ITI_duration: jsPsych.randomization.sampleWithReplacement([400,420,440,460,480,500,520,540,560,580,600,620,640,660,680,700], 1)},
    {test_part: 'test', colour: 'rgb('+green_rgb+')', text: "RED", condition: "incongruent", correct_response: 'G', ITI_duration: jsPsych.randomization.sampleWithReplacement([400,420,440,460,480,500,520,540,560,580,600,620,640,660,680,700], 1)},
    {test_part: 'test', colour: 'rgb('+red_rgb+')', text: "BLUE", condition: "incongruent", correct_response: 'R', ITI_duration: jsPsych.randomization.sampleWithReplacement([400,420,440,460,480,500,520,540,560,580,600,620,640,660,680,700], 1)},
    {test_part: 'test', colour: 'rgb('+red_rgb+')', text: "GREEN", condition: "incongruent", correct_response: 'R', ITI_duration: jsPsych.randomization.sampleWithReplacement([400,420,440,460,480,500,520,540,560,580,600,620,640,660,680,700], 1)},
    ],
    sample: {
        type: 'custom',
        fn: function(t){
          // first sample 12 congruent and 6 congruent trials (with replacement)
          t_congruent = jsPsych.randomization.sampleWithReplacement([0,1,2], 12)
          t_incongruent = jsPsych.randomization.sampleWithReplacement([3,4,5,6,7,8], 6)
          t_unshuffled = t_congruent.concat(t_incongruent)
          // then shuffle their order
          t = jsPsych.randomization.sampleWithoutReplacement(t_unshuffled, 18)
          return t; //
        }
    }
}

var rest_block = {
    type: 'instructions',
    pages: [
      "REST BREAK <br> The task has changed. You will either have more or less time to respond before the beep. <br> Press the Spacebar when you are ready to go on.",
      ],
    key_forward: ' '
}

function update_adaptive_window_block_1_6() {
  n_cor = jsPsych.data.get().filter({test_part: 'test'}).last(18).filter({correct: true}).count()
  if (n_cor >= 15){
      adaptive_trial_duration -= 90;
  }  else {
      adaptive_trial_duration += 270;
  }
}

var update_adaptive_window_first_blocks = {
  type: 'call-function',
  func: update_adaptive_window_block_1_6
}

function update_adaptive_window_block_7_12() {
  n_cor = jsPsych.data.get().filter({test_part: 'test'}).last(18).filter({correct: true}).count()
  if (n_cor >= 15){
      adaptive_trial_duration -= 30;
  }  else {
      adaptive_trial_duration += 90;
  }
}

var update_adaptive_window_last_blocks = {
  type: 'call-function',
  func: update_adaptive_window_block_7_12
}

var final_page = {
  type: 'html-keyboard-response',
  stimulus: 'Task done! Please press the space bar to get redirected back to the next part'
}

var first_blocks = {
      timeline: [trial_block, update_adaptive_window_first_blocks, rest_block],
      repetitions: 6,
    }

var last_blocks = {
      timeline: [trial_block, update_adaptive_window_last_blocks, rest_block],
      repetitions: 12,
    }

jsPsych.init({
  timeline: [opening_screen, fix_audio, fullscreen_trial, cursor_off, first_instructions, xxx_practice_block, second_instructions, untimed_normal_practice_block, third_instructions, normal_practice_block, normal_practice_block, fourth_instructions, first_blocks, last_blocks, cursor_on, final_page],
  on_finish: function() {
    var json_data = jsPsych.data.get().json();
        Shiny.setInputValue("jspsych_results", json_data);
        location.reload();
}
});
