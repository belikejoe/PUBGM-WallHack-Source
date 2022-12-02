#import "x2nios.h"

#import "Esp/ImGuiDrawView.h"
#import <Metal/Metal.h>
#import <MetalKit/MetalKit.h>
#import <Foundation/Foundation.h>
#include "KittyMemory/imgui.h"
#include "KittyMemory/imgui_impl_metal.h"
#import <Foundation/Foundation.h>
#import "Esp/CaptainHook.h"
#include "Esp/ESP.h" 

#define kWidth  [UIScreen mainScreen].bounds.size.width
#define kHeight [UIScreen mainScreen].bounds.size.height
#define kScale [UIScreen mainScreen].scale
#define kTest   0 
#define g 0.86602540378444 

@interface ImGuiDrawView () <MTKViewDelegate>
//@property (nonatomic, strong) IBOutlet MTKView *mtkView;
@property (nonatomic, strong) id <MTLDevice> device;
@property (nonatomic, strong) id <MTLCommandQueue> commandQueue;






@property (nonatomic,  strong) UILabel *numberLabel;


@property (nonatomic,  strong) CAShapeLayer *Line_Red;
@property (nonatomic,  strong) CAShapeLayer *Line_Green;

@property (nonatomic, strong) NSArray *numberData;
@property (nonatomic,  strong) CAShapeLayer *renji;
@property (nonatomic,  strong) NSArray *rects;
@property (nonatomic,  strong) NSArray *aiData;
@property (nonatomic,  strong) NSArray *hpData;
@property (nonatomic,  strong) NSArray *disData;
@property (nonatomic,  strong) NSArray *nameData;
@property (nonatomic,  strong) NSArray *data1;
@property (nonatomic,  strong) NSArray *data2;
@property (nonatomic,  strong) NSArray *data3;
@property (nonatomic,  strong) NSArray *data4;
@property (nonatomic,  strong) NSArray *data5;
@property (nonatomic,  strong) NSArray *data6;
@property (nonatomic,  strong) NSArray *data7;
@property (nonatomic,  strong) NSArray *data8;
@property (nonatomic, copy) NSString *Name;
@property (nonatomic, copy) NSString *juli;
@property (nonatomic,  weak) NSTimer *timer;
@property  char renshu;

@property (nonatomic, copy) NSString *zhutitle;
@property (nonatomic, copy) NSString *fubiaoti;
@property (nonatomic, copy) NSString *kaiguan;
@property (nonatomic, copy) NSString *shexian;
@property (nonatomic, copy) NSString *guge;
@property (nonatomic, copy) NSString *xuetiao;
@property (nonatomic, copy) NSString *xinxi;
@property (nonatomic, copy) NSString *fujin;
@property (nonatomic, copy) NSString *quan;




@end


float headx;
float heady;
#define Red 0x990000ff
#define Green 0x9900FF00
#define Yellow 0x9900ffff
#define Blue 0x99ff0000
#define Pink 0x99eb8cfe
#define White 0xffffffff

@implementation ImGuiDrawView


static bool MenDeal = true;


- (instancetype)initWithNibName:(nullable NSString *)nibNameOrNil bundle:(nullable NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];

    _device = MTLCreateSystemDefaultDevice();
    _commandQueue = [_device newCommandQueue];

    if (!self.device) abort();

    IMGUI_CHECKVERSION();
    ImGui::CreateContext();
    ImGuiIO& io = ImGui::GetIO(); (void)io;

    ImGui::StyleColorsDark();
    
NSString *FontPath = @"/System/Library/Fonts/AppFonts/Charter.ttc";
    io.Fonts->AddFontFromFileTTF(FontPath.UTF8String, 40.f,NULL,io.Fonts->GetGlyphRangesChineseSimplifiedCommon());



    
    ImGui_ImplMetal_Init(_device);

    return self;
}

+ (void)showChange:(BOOL)open
{
    MenDeal = open;
}

- (MTKView *)mtkView
{
    return (MTKView *)self.view;
}

- (void)loadView
{
    CGFloat w = [UIApplication sharedApplication].windows[0].rootViewController.view.frame.size.width;
    CGFloat h = [UIApplication sharedApplication].windows[0].rootViewController.view.frame.size.height;
    self.view = [[MTKView alloc] initWithFrame:CGRectMake(0, 0, w, h)];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.mtkView.device = self.device;
    self.mtkView.delegate = self;
    self.mtkView.clearColor = MTLClearColorMake(0, 0, 0, 0);
    self.mtkView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0];
    self.mtkView.clipsToBounds = YES;
}

- (void)conData:(NSArray *)rects hpData:(NSArray *)hpData disData:(NSArray *)disData nameData:(NSArray *)nameData aiData:(NSArray *)aiData numberData:(NSArray *)numberData data1:(NSArray *)data1  data2:(NSArray *)data2 data3:(NSArray *)data3 data4:(NSArray *)data4 data5:(NSArray *)data5 data6:(NSArray *)data6 data7:(NSArray *)data7 data8:(NSArray *)data8
{

    _rects = rects;
    _hpData = hpData;
    _disData = disData;
    _nameData = nameData;
    _aiData = aiData;
    _numberData = numberData;
    _data1 =  data1;
    _data2 =  data2;
    _data3 =  data3;
    _data4 =  data4;
    _data5 =  data5;
    _data6 =  data6;
    _data7 =  data7;
    _data8 =  data8;
     _numberLabel.text = @(_rects.count).stringValue;
//



}







#pragma mark - Interaction

- (void)updateIOWithTouchEvent:(UIEvent *)event
{
    UITouch *anyTouch = event.allTouches.anyObject;
    CGPoint touchLocation = [anyTouch locationInView:self.view];
    ImGuiIO &io = ImGui::GetIO();
    io.MousePos = ImVec2(touchLocation.x, touchLocation.y);

    BOOL hasActiveTouch = NO;
    for (UITouch *touch in event.allTouches)
    {
        if (touch.phase != UITouchPhaseEnded && touch.phase != UITouchPhaseCancelled)
        {
            hasActiveTouch = YES;
            break;
        }
    }
    io.MouseDown[0] = hasActiveTouch;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self updateIOWithTouchEvent:event];
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self updateIOWithTouchEvent:event];
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self updateIOWithTouchEvent:event];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self updateIOWithTouchEvent:event];
}

#pragma mark - MTKViewDelegate

- (void)drawInMTKView:(MTKView*)view
{
    
    [self doTheJob];
    NSLog(@"99999888===%lu",(unsigned long)_rects.count);
    ImGuiIO& io = ImGui::GetIO();
    io.DisplaySize.x = view.bounds.size.width;
    io.DisplaySize.y = view.bounds.size.height;

    CGFloat framebufferScale = view.window.screen.scale ?: UIScreen.mainScreen.scale;
    io.DisplayFramebufferScale = ImVec2(framebufferScale, framebufferScale);
    io.DeltaTime = 1 / float(view.preferredFramesPerSecond ?: 60);
    
    id<MTLCommandBuffer> commandBuffer = [self.commandQueue commandBuffer];
    
    static bool show_lien = false;
    static bool show_guge = false;
    static bool show_name = false;
    static bool show_round = false;
    static bool show_number = false;
    static bool show_xuetiao = false;
    static bool show_xinxi = false;
    static bool show_wuhou = false;
    static bool show_fanwei = false;
    static bool show_neifang = false;
    
static int ded = 160;

        static int circle_size = 160;
        
        //
        if (MenDeal == true) {
            [self.view setUserInteractionEnabled:YES];
        } else if (MenDeal == false) {
            [self.view setUserInteractionEnabled:NO];
        }

        MTLRenderPassDescriptor* renderPassDescriptor = view.currentRenderPassDescriptor;
        if (renderPassDescriptor != nil)
        {
            id <MTLRenderCommandEncoder> renderEncoder = [commandBuffer renderCommandEncoderWithDescriptor:renderPassDescriptor];
            [renderEncoder pushDebugGroup:@"ImGui Jane"];

            ImGui_ImplMetal_NewFrame(renderPassDescriptor);
            ImGui::NewFrame();
            
            ImFont* font = ImGui::GetFont();
            font->Scale = 16.f / font->FontSize;
            
            CGFloat x = (([UIApplication sharedApplication].windows[0].rootViewController.view.frame.size.width) - 360) / 2;
            CGFloat y = (([UIApplication sharedApplication].windows[0].rootViewController.view.frame.size.height) - 320) / 2;
            
            ImGui::SetNextWindowPos(ImVec2(x, y), ImGuiCond_FirstUseEver);
            ImGui::SetNextWindowSize(ImVec2(360, 320), ImGuiCond_FirstUseEver);
            
            if (MenDeal == true)
            {

                
                ImGui::Begin("YAHYA IOS", &MenDeal);
                ImGui::Checkbox("BONE", &show_lien);
                ImGui::Checkbox("NAME", &show_xuetiao);
                ImGui::Checkbox("HEALTH", &show_name); 
                ImGui::Checkbox("ID PLAYER", &show_number);
                ImGui::Checkbox("BULITRACK", &show_xinxi);
              
                ImGui::Text("Telegram: t.me/PUBG_M0BILE_ROBOT\n\nBY: YAHYAIOS\n\n© 2021. All rights reserved %.3f ms/frame (%.1f FPS)", 500.0f / ImGui::GetIO().Framerate, ImGui::GetIO().Framerate);
                ImGui::End();
                
            }
            ImDrawList* draw_list = ImGui::GetForegroundDrawList();
            float wanjia =0;
            for (int i = 0; i < self->_rects.count; i++) {
                   
                NSValue *val0  = self->_rects[i];
                NSNumber *val1 = self->_hpData[i];
                NSNumber *val2 = self->_disData[i];
                NSNumber *val3 = self->_aiData[i];
                   
                NSValue *d1  = self->_data1[i];
                NSValue *d2  = self->_data2[i];
                NSValue *d3  = self->_data3[i];
                NSValue *d4  = self->_data4[i];
                NSValue *d5  = self->_data5[i];
                NSValue *d6  = self->_data6[i];
                NSValue *d7  = self->_data7[i];
                NSValue *d8  = self->_data8[i];
                self->_Name = _nameData[i];
                CGRect rect = [val0 CGRectValue];
                CGFloat xue = [val1 floatValue];
                CGFloat dis = [val2 floatValue];
                CGRect rect1 = [d1 CGRectValue];
                CGRect rect2 = [d2 CGRectValue];
                CGRect rect3 = [d3 CGRectValue];
                CGRect rect4 = [d4 CGRectValue];
                CGRect rect5 = [d5 CGRectValue];
                CGRect rect6 = [d6 CGRectValue];
                CGRect rect7 = [d7 CGRectValue];
                CGRect rect8 = [d8 CGRectValue];
                _renshu =self->_rects.count;
                _juli =[NSString stringWithFormat:@"[%.1fhp]",xue];
                
                CGFloat headx = rect1.origin.x/kScale;
                CGFloat heady = rect1.origin.y/kScale;
                CGFloat Spinex = rect1.size.width/kScale;
                CGFloat Spiney = rect1.size.height/kScale;
                CGFloat pelvisx = rect2.origin.x/kScale;
                CGFloat pelvisy = rect2.origin.y/kScale;
                CGFloat leftShoulderx = rect2.size.width/kScale;
                CGFloat leftShouldery = rect2.size.height/kScale;
                CGFloat leftElbowx = rect3.origin.x/kScale;
                CGFloat leftElbowy = rect3.origin.y/kScale;
                CGFloat leftHandx = rect3.size.width/kScale;
                CGFloat leftHandy = rect3.size.height/kScale;
                CGFloat rightShoulderx = rect4.origin.x/kScale;
                CGFloat rightShouldery = rect4.origin.y/kScale;
                CGFloat rightElbowx = rect4.size.width/kScale;
                CGFloat rightElbowy = rect4.size.height/kScale;
                CGFloat rightHandx = rect5.origin.x/kScale;
                CGFloat rightHandy = rect5.origin.y/kScale;
                CGFloat leftPelvisx = rect5.size.width/kScale;
                CGFloat leftPelvisy = rect5.size.height/kScale;
                CGFloat leftKneex = rect6.origin.x/kScale;
                CGFloat leftKneey = rect6.origin.y/kScale;
                CGFloat leftFootx = rect6.size.width/kScale;
                CGFloat leftFooty = rect6.size.height/kScale;
                CGFloat rightPelvisx = rect7.origin.x/kScale;
                CGFloat rightPelvisy = rect7.origin.y/kScale;
                CGFloat rightKneex = rect7.size.width/kScale;
                CGFloat rightKneey = rect7.size.height/kScale;
                CGFloat rightFootx = rect8.origin.x/kScale;
                CGFloat rightFooty = rect8.origin.y/kScale;
                float xd = rect.origin.x+rect.size.width/2;
                float yd = rect.origin.y;
                
                CGFloat w = rect.size.width;
                CGFloat h = rect.size.height;
             
                wanjia+=1;
                if ([val3 intValue] == 1) {
                    self->_Name=[NSString stringWithFormat:@"Bot"];
                }
                if (xue<1) {
                    _Name=[NSString stringWithFormat:@"击倒"];
                }
              
                if (show_lien) {
                    if ([_Name containsString:@"Ai"]) {
                        draw_list->AddLine(ImVec2(kWidth*0.5, 40), ImVec2(xd, yd-60), Green,0.1);
                    }else{
                        draw_list->AddLine(ImVec2(kWidth*0.5, 40), ImVec2(xd, yd-40), Red,0.1);
                        
                    }
                    
                }
             
                if (show_xuetiao) {
                    if (xue>0) {
                      
                        draw_list->AddRectFilled(ImVec2(xd-50, yd-12), ImVec2(xd-50+xue, yd-8), Green);
                   
                        draw_list->AddRectFilled(ImVec2(xd-50+xue, yd-8), ImVec2(xd+50, yd-12), Red);
                    }
                    
                    
                    draw_list->AddLine(ImVec2(xd-5, yd-9), ImVec2(xd, yd-6), Green);
                    draw_list->AddLine(ImVec2(xd, yd-6), ImVec2(xd+5, yd-9), Green);
                    
                }
             
                if (show_xinxi) {
                    if ([_Name containsString:@"Ai"]) {
                      
                        draw_list->AddRectFilled(ImVec2(xd-30, yd-30), ImVec2(xd+30, yd-11), Green);
                       
                        draw_list->AddRectFilled(ImVec2(xd-30, yd-10), ImVec2(xd-30, yd-11), Blue);
                       
                        char* ii = (char*) [[NSString stringWithFormat:@"%d",(int)i+1] cStringUsingEncoding:NSUTF8StringEncoding];
                        draw_list->AddText(ImGui::GetFont(), 20, ImVec2(xd-25, yd-31), White, ii);
                        
                    }
                    else if ([_Name containsString:@"击倒"]) {
                  
                        draw_list->AddRectFilled(ImVec2(xd-30, yd-30), ImVec2(xd+30, yd-11), White);
                      
                        draw_list->AddRectFilled(ImVec2(xd-30, yd-10), ImVec2(xd-30, yd-11), Blue);
                     
                        char* ii = (char*) [[NSString stringWithFormat:@"%d",(int)i+1] cStringUsingEncoding:NSUTF8StringEncoding];
                        draw_list->AddText(ImGui::GetFont(), 20, ImVec2(xd-25, yd-31), White, ii);
                       
                    }
                    else{
                       
                        draw_list->AddRectFilled(ImVec2(xd-50, yd-30), ImVec2(xd+50, yd-11), Blue);
                        
                        draw_list->AddRectFilled(ImVec2(xd-50, yd-30), ImVec2(xd-30, yd-11), Blue);
                     
                        char* ii = (char*) [[NSString stringWithFormat:@"%d",(int)i+1] cStringUsingEncoding:NSUTF8StringEncoding];
                        draw_list->AddText(ImGui::GetFont(), 20, ImVec2(xd-45, yd-31), White, ii);
                    }
                    
                   
                    
                }
               
                if (show_name) {
                    char* TermConfig = (char*) [_Name cStringUsingEncoding:NSUTF8StringEncoding];
                    char* distxt = (char*) [_juli cStringUsingEncoding:NSUTF8StringEncoding];
                    draw_list->AddText(ImGui::GetFont(), 15, ImVec2(xd-20, yd-45), 0xFF00FF00, distxt);
                    if ([_Name containsString:@"击倒"]) {
                        draw_list->AddText(ImGui::GetFont(), 15, ImVec2(xd-10, yd-29), Red, TermConfig);
                    }else{
                        draw_list->AddText(ImGui::GetFont(), 15, ImVec2(xd-26, yd-29), White, TermConfig);
                    }
                    
                    
                   
                }
            }
        
            if (show_number) {
                 char* newnumber = (char*) [[NSString stringWithFormat:@"%d ",_renshu] cStringUsingEncoding:NSUTF8StringEncoding];
                draw_list->AddText(ImGui::GetFont(), 38, ImVec2(kWidth/2, 15), 0xFFCCFFFF,newnumber);
                
                
            }
            
              
        
            ImGui::Render();
            ImDrawData* draw_data = ImGui::GetDrawData();
            ImGui_ImplMetal_RenderDrawData(draw_data, commandBuffer, renderEncoder);

            [renderEncoder popDebugGroup];
            [renderEncoder endEncoding];

            [commandBuffer presentDrawable:view.currentDrawable];
        }

        [commandBuffer commit];
}


- (void)mtkView:(MTKView*)view drawableSizeWillChange:(CGSize)size
{
    
}
- (void)fuyanqaq:(NSArray *)rects hpData:(NSArray *)hpData disData:(NSArray *)disData nameData:(NSArray *)nameData aiData:(NSArray *)aiData data1:(NSArray *)data1  data2:(NSArray *)data2 data3:(NSArray *)data3 data4:(NSArray *)data4 data5:(NSArray *)data5 data6:(NSArray *)data6 data7:(NSArray *)data7 data8:(NSArray *)data8
{
    self->_rects = rects;
    self->_hpData = hpData;
    self->_disData = disData;
    self->_nameData = nameData;
    self->_aiData = aiData;
    self->_data1 =  data1;
    self->_data2 =  data2;
    self->_data3 =  data3;
    self->_data4 =  data4;
    self->_data5 =  data5;
    self->_data6 =  data6;
    self->_data7 =  data7;
    self->_data8 =  data8;
    
}
- (void)doTheJob
{

    [[lvllzuobiao data] fetchData:^(NSArray * _Nonnull data, NSArray * _Nonnull hpData, NSArray * _Nonnull disData,  NSArray * _Nonnull nameData,  NSArray * _Nonnull aiData, NSArray * _Nonnull data1, NSArray * _Nonnull data2, NSArray * _Nonnull data3, NSArray * _Nonnull data4, NSArray * _Nonnull data5, NSArray * _Nonnull data6, NSArray * _Nonnull data7, NSArray * _Nonnull data8) {
         NSLog(@"%@",data1);
        [self fuyanqaq:data hpData:hpData disData:disData nameData:nameData aiData:aiData data1:data1 data2:data2 data3:data3 data4:data4 data5:data5 data6:data6 data7:data7 data8:data8];
    }];

}



@end

