%% creating a mask


figure
imagesc(ct_im)
set(gcf, 'Position', get(0,'Screensize')); % Maximize figure.
message = sprintf('Left click and hold to begin drawing around the home compartment.\nSimply lift the mouse button to finish');
uiwait(msgbox(message));
hFH = impoly();
h_mask = hFH.createMask();
imagesc(h_mask)
%%
r_mask=zeros(size(ct_im));
temp_r=ct_im;
temp_r(:,:,:)=0;
temp_r1=temp_r(:,:,1);
temp_r1(:,:,:)=0;
imagesc(temp_r1)


%%

for lena=1:13
    
end
