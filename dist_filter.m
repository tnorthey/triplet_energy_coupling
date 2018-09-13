function[dist_,x]=dist_filter(fname,Na,Nb,cutoff)
% dist_filter: Reads xyz trajectory, for each frame determines distance between molecule a (which has Na atoms) and molecule b (which has Nb atoms), filters out any further apart than the cutoff radius, and outputs .coords files for each nearby frame

  Ntot = Na + Nb;  % total number of atoms

  A=dlmread(fname);
  B=A(A(:,1)~=Ntot,:);
  A=B(sum(B,2)~=0,:);  % remove unwanted rows
  A=A(:,2:end);  % remove first column
  
  Nframes = size(A,1)/Ntot;  % total number of frames
  disp('number of frames = ')
  disp(Nframes)
 
  dirname=[fname,'_fed'];
  mkdir(dirname);  % create directory to store files

  dist_ = zeros(Nframes,1);
  for i=1:Nframes
    
    frame=A((i-1)*Ntot+1:i*Ntot,:);  % frame coords
    a=frame(1:Na,:);  % coords of a
    b=frame(Na+1:Ntot,:);  % coords of b
    centreA = sum(a,1)/size(a,1);  % geometric centre of molecule a
    centreB = sum(b,1)/size(b,1);  % geometric centre of molecule b
    dist_(i) = sqrt(sum((centreA-centreB).^2));  % distance between geometric centres
    if dist_(i) < cutoff
      dlmwrite([dirname,'/frame',num2str(i,'%03.f'),'.coords'],frame,' ')  
    end
  end

  x = 1:Nframes;
  x = x(dist_<cutoff);
  
  disp(['number of frames with r< ',num2str(cutoff),' = '])
  disp(length(x))
  
  dlmwrite([dirname,'/dist.dat'],dist_,'precision','%.8f')
  dlmwrite([dirname,'/index.list'],x')

return
