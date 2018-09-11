function[dist_,x]=dist_filter(fname,cutoff)
  
  Na=23;  % size of fragment a
  Nb=12;  % size of fragment b
  Ntot = Na + Nb;  % total size

  A=dlmread(fname);
  B=A(A(:,1)~=35,:);
  A=B(sum(B,2)~=0,:);  % remove unwanted rows
  A=A(:,2:end);  % remove first column
  
  Nframes = size(A,1)/Ntot;
  disp('number of frames = ')
  disp(Nframes)

  dist_ = zeros(Nframes,1);
  for i=1:Nframes
    
    frame=A((i-1)*Ntot+1:i*Ntot,:);
    a=frame(1:Na,:);
    b=frame(Na+1:Ntot,:);
    centreA = sum(a,1)/size(a,1);  % geometric centre of molecule a
    centreB = sum(b,1)/size(b,1);  % geometric centre of molecule b
    dist_(i) = sqrt(sum((centreA-centreB).^2));  % distance between centres
    if dist_(i) < cutoff
      dlmwrite(strcat('frame',num2str(i,'%03.f'),'.coords'),frame,' ')  
    end
  end

  x = 1:1000;
  x = x(dist_<cutoff);
  
  disp(strcat('number of frames with r< ',num2str(cutoff),' = '))
  disp(length(x))
  
  dlmwrite('dist.dat',dist_,'precision','%.8f')
  dlmwrite('index.list',x')


return
