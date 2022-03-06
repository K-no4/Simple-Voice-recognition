clear
sigchoosen=0;
n=1;
p=1;
Fs=44000;
%%v=linspace(0,2);
t=0:1/44000:3;
c=1;
v=1;

while p>=1
    p=input('\nSelect which action numbered 0-6\n1. Select audio file/audio file name/enunciation\n2.Record audio\n3.Select sigma value\n4.Compute and graph intergral transform of curently selected audio file\n5.play audio of original file\n6.Use step function (debuging)\n0.exit program\n');
    switch(p)
        case 1
            clearvars -except p 
            filename= selectword();
            if isfile(filename)
            [bt,fs]=audioread(filename);
            else
            end
        case 2
            clear bt
          t=0:1/33600:3;
          t=t(1:end-1);
          Fs=33600;
            recorder= audiorecorder(Fs,16,1);
            disp('recording audio for 2 seconds');
            recordblocking(recorder,3);
            disp('recording ended');
            bt=getaudiodata(recorder);
                          main1=bt;
                          main1(main1<=0.001&main1>=-0.001)=[];
                  I=length(main1);
  M=0:1:I;
  M=M*(1/33600);
  M=M(1:end-1);
          figure(1)
          plot(M,main1)
          hold on
        case 3
          sig=sigmainput();
          sigchoosen=1;
          
        case 4
              i=0:2*pi:30000*pi;  
                Lk=Transform(bt);
                L=numel(Lk);
              jhh=angle(Lk);
              jh=(Lk); 
               lo=normalize(abs(jh));
                lo(lo<=0)=[];
              hold on
              figure(3)
              plot(lo)
              xlabel( 'frequency')
              ylabel('X(Omega)')
              hold on

            

        case 5
            playaudio(bt);
        case 6
            bt=heaviside(0.5-t);
            bt=transpose(bt(1:end-1));
        case 7 
            sum=zeros(length(btotal),1);
            [row,col]=size(btotal);
            for i=1:col
                sum=sum+btotal(:,i);
            end
            main=sum/row;
            figure(4)
            plot(main)
        case 0
            e=0;
        otherwise
            disp('The action that has been selected is not recognized please choose a given option')
    end
end

function sig=sigmainput()
    sig=input('Input a real positive number: ');
end

function filename=selectword()
v=input('Eneter values 1-5 to select which wordto use:\n1.sunshine \n2. fun-time\n3. land-line\n4. sore-thumb\n5. core-dump\n');
    switch(v)
        case 1
            filename='sunshine.wav';
        case 2
            filename='fun_time.wav';
        case 3
            filename='land_line.wav';
        case 4
            filename='sore_thumb.wav';
        case 5
            filename='core_dump.wav';
    end
end    

function bt=recordAudio(filename)
clear
Fs=33600;
recorder= audiorecorder(Fs,16,1);
disp('recording audio for 2 seconds');
recordblocking(recorder,3);
disp('recording ended');
bt=getaudiodata(recorder);
audiowrite(filename, bt, Fs);
disp('audio file saved');
end

function Vb=Transform(x)
c=1;
Vb=zeros(1,15001);
t=0:1/33600:3;
t=t(1:end-1);
for w=0:5*pi:5000*pi
    Lkk=(exp(-1*(1i*w).*t));
    LK=Lkk*x;
    Vb(c)=LK;
    c=c+1;
end
end
function playaudio(bt)
Fs=33600;
   sound(bt,Fs)

end
function fixed=fix_shape(main0,voicerec)
main0(main0<=-0.043&main0>=0.042)=[];
voicerec(voicerec<=-0.043&voicerec>=0.042)=[];
if length(main0)<length(voicerec)
    main0(length(main0):1:length(voicerec))=0;
elseif length(voicerec)<length(main0)
    voicerec(length(voicerec):1:length(main0))=0;
end
fixed=[main0;voicerec];
end