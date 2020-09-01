function []= position_color(value,Position,background)
Hintergrund=background;
PositionH=Position;
Irate=value;
%% Add Position with EOD color plot
x=PositionH(:,1);y= PositionH(:,2);
colormap2 = jet(sum(~isnan(Irate)));alpha=0.6;alpha2=0.6;
s=sort(Irate(~isnan(Irate)));circle=8;
numPoints=100; 
theta=linspace(0,2*pi,numPoints); %100 evenly spaced points between 0 and 2pi
%imshow(cat(3,Hintergrund,Hintergrund,Hintergrund)); hold on
figure
imshow(Hintergrund);hold on
for i=1:size(x)
if ~isnan(Irate(i))
col=colormap2((find(Irate(i)<=s,1)),:);
fPos = get(gcf, 'Position');
xl = xlim(); yl = ylim();
w = circle*(xl(2)-xl(1))/fPos(3);
h = circle*(yl(2)-yl(1))/fPos(4);
mx = w*sin(theta); my = h*cos(theta);
patch(x(i)+mx, y(i)+my*0.8,col, 'FaceColor', col, 'FaceAlpha', alpha2, 'EdgeColor', 'none');
else
col=colormap2((find(Irate(i)<=s,1)),:);
fPos = get(gcf, 'Position');
xl = xlim(); yl = ylim();
w = 2*(xl(2)-xl(1))/fPos(3);h = 2*(yl(2)-yl(1))/fPos(4);
mx = w*sin(theta); my = h*cos(theta);
patch(x(i)+mx, y(i)+my*0.8,[0 0 0], 'FaceColor', [0 0 0], 'FaceAlpha', alpha2, 'EdgeColor', [0 0 0]);
end
end
hcb=colorbar;
set(get(colorbar,'ylabel'),'String', 'EOD rate')
%scatter(PositionH(:,1),PositionH(:,2),44,Irate,'filled')

end 