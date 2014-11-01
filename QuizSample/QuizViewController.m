//
//  QuizViewController.m
//  QuizSample
//
//  Created by Master on 2014/11/01.
//  Copyright (c) 2014年 net.masuhara. All rights reserved.
//

#import "QuizViewController.h"


@interface QuizViewController ()
<UIAlertViewDelegate>

@end

@implementation QuizViewController

{
    int currentQuiz;
    int correctAnswer;
    AVAudioPlayer *questionSound, *correctSound, *incorrectSound;
    NSMutableArray *quizArray;
    IBOutlet UITextView *problemTextView;
    IBOutlet UIImageView *quizImageView;
    IBOutlet UIButton *buttonA, *buttonB, *buttonC;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    currentQuiz = 0;
    correctAnswer = 0;
    
    quizArray = [NSMutableArray new];
    quizArray = [self shuffleQuiz:[self setQuiz]];
    
    buttonA.tag = 1;
    buttonB.tag = 2;
    buttonC.tag = 3;
    
    [self setSounds];
    [self setQuestions];
}

- (void)viewDidAppear:(BOOL)animated
{
    [questionSound play];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



- (NSMutableArray *)shuffleQuiz:(NSMutableArray *)qArray
{
    int numberOfQuiz = (int)[qArray count];
    
    for (int i = numberOfQuiz - 1; i > 0; i--) {
        int randNumber = arc4random() % i;
        [qArray exchangeObjectAtIndex:i withObjectAtIndex:randNumber];
    }
    
    NSLog(@"問題一覧 %@", qArray);
    
    return qArray;
}



#pragma mark - IBAction

- (IBAction)selectAnswer:(UIButton *)selectedButton
{
    if (selectedButton.tag == [[quizArray[currentQuiz] objectAtIndex:0] intValue]) {
        //正解だったとき
        [correctSound play];
        correctAnswer++;
    }else{
        //不正解だったとき
        [incorrectSound play];
    }
    
    currentQuiz++;
    [self setQuestions];
}


#pragma mark - Sounds

- (void)setSounds
{
    //問題が出たときの音
    NSString *questionSoundPath = [[NSBundle mainBundle] pathForResource:@"question" ofType:@"wav"];
    NSURL *questionSoundURL = [NSURL fileURLWithPath:questionSoundPath];
    
    //正解したときの音
    NSString *correctSoundPath = [[NSBundle mainBundle] pathForResource:@"correct" ofType:@"wav"];
    NSURL *correctSoundURL = [NSURL fileURLWithPath:correctSoundPath];
    
    //不正解だったときの音
    NSString *incorrectSoundPath = [[NSBundle mainBundle] pathForResource:@"incorrect" ofType:@"wav"];
    NSURL *incorrectSoundURL = [NSURL fileURLWithPath:incorrectSoundPath];
    
    
    questionSound = [[AVAudioPlayer alloc] initWithContentsOfURL:questionSoundURL error:nil];
    correctSound = [[AVAudioPlayer alloc] initWithContentsOfURL:correctSoundURL error:nil];
    incorrectSound = [[AVAudioPlayer alloc] initWithContentsOfURL:incorrectSoundURL error:nil];
    
    [questionSound prepareToPlay];
    [correctSound prepareToPlay];
    [incorrectSound prepareToPlay];
}



#pragma mark - Quiz

- (NSMutableArray *)setQuiz
{
    [quizArray addObject:[NSArray arrayWithObjects:@"2", [UIImage imageNamed:@"chabatake.png"], @"この地図記号が表す場所はどこ？", @"病院", @"茶畑", @"銀行", nil]];
    [quizArray addObject:[NSArray arrayWithObjects:@"1", [UIImage imageNamed:@"ginko.png"], @"この地図記号が表す場所はどこ？", @"銀行", @"市役所", @"検察庁", nil]];
    [quizArray addObject:[NSArray arrayWithObjects:@"3", [UIImage imageNamed:@"shiyakusho.png"], @"この地図記号が表す場所はどこ？", @"城跡", @"田んぼ", @"市役所", nil]];
    [quizArray addObject:[NSArray arrayWithObjects:@"1", [UIImage imageNamed:@"hatake.png"], @"この地図記号が表す場所はどこ？", @"畑", @"田んぼ", @"森林", nil]];
    [quizArray addObject:[NSArray arrayWithObjects:@"1", [UIImage imageNamed:@"joseki.png"], @"この地図記号が表す場所はどこ？", @"城跡", @"灯台", @"区役所", nil]];
    [quizArray addObject:[NSArray arrayWithObjects:@"3", [UIImage imageNamed:@"tanbo.png"], @"この地図記号が表す場所はどこ？", @"畑", @"茶畑", @"田んぼ", nil]];
    [quizArray addObject:[NSArray arrayWithObjects:@"2", [UIImage imageNamed:@"byoin.png"], @"この地図記号が表す場所はどこ？", @"教会", @"病院", @"保健所", nil]];
    [quizArray addObject:[NSArray arrayWithObjects:@"2", [UIImage imageNamed:@"kensatsucho.png"], @"この地図記号が表す場所はどこ？", @"国会議事堂", @"検察庁", @"発電所", nil]];
    
    
    return quizArray;
}


- (void)setQuestions
{
    if (currentQuiz < quizArray.count) {
        quizImageView.image = [quizArray[currentQuiz] objectAtIndex:1];
        problemTextView.text = [quizArray[currentQuiz] objectAtIndex:2];
        [buttonA setTitle:[quizArray[currentQuiz] objectAtIndex:3] forState:UIControlStateNormal];
        [buttonB setTitle:[quizArray[currentQuiz] objectAtIndex:4] forState:UIControlStateNormal];
        [buttonC setTitle:[quizArray[currentQuiz] objectAtIndex:5] forState:UIControlStateNormal];
    }else{
        NSString *messageString = [NSString stringWithFormat:@"%d問中、%d問正解でした！",currentQuiz, correctAnswer];
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"結果" message:messageString delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
        [alertView show];
    }
}

#pragma mark - UIAlertView Delegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex) {
        case 0:
            [self dismissViewControllerAnimated:YES completion:nil];
            break;
        default:
            break;
    }
}

@end
