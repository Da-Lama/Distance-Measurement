function [h_mask] = create_mask(image)

ct_im=image;
figure
imagesc(ct_im)
set(gcf, 'Position', get(0,'Screensize')); % Maximize figure.
message = sprintf('Left click to create a polygon.\nSimply lift the mouse button to finish');
uiwait(msgbox(message));
hFH = impoly();
h_mask = hFH.createMask();
% rFH = imrect();
% r_mask=rFH.createMask();

end 