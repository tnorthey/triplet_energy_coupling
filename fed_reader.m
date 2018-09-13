function[t1t1,t1t2,dist]=fed_reader()
  
  c=0;
  dist = [];
  t1t1=dist; t1t2=dist;
  D=dlmread('dist.dat');

  A = dlmread('triplet_states.txt');
  donor_states=A(abs(A(:,2))>1,:);
  acceptor_states=A(abs(A(:,3))>1,:);
  
  if size(acceptor_states,1)==0 || size(donor_states,1)==0
    continue  % skip to next loop iteration
  end 
  
  c = c + 1;
  framenumber = fname(21:23);
  dist(c) = D(str2num(framenumber));

  fname = 'fed_couplings_frame.txt'];
  A = dlmread(fname);
  
  % determine state ordering
  acceptor_t1 = acceptor_states(1,1);
  donor_t1 = donor_states(1,1);
  donor_t2 = donor_states(2,1);
  
  % read FED couplings
  for i=1:size(A,1)
    a=A(i,1); b=A(i,2);
    coupling = A(i,6);
    if a==acceptor_t1 && b==donor_t1
      t1t1(c) = coupling;
    elseif a==acceptor_t1 && b==donor_t2
      t1t2(c) = coupling;
    elseif b==acceptor_t1 && a==donor_t1
      t1t1(c) = coupling;
    elseif b==acceptor_t1 && a==donor_t2
      t1t2(c) = coupling;
    end
  end
  
return
