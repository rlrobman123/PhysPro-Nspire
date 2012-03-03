--This document should contain the glue for all the plugins

function pushanalysis() 
	push_screen(Analysis)
end

function pushformulapro()
	only_screen(CategorySel)
end

function pushreference()
	only_screen(Ref)
end

main	=	Screen()
main.sel	= 1
main.items	= {
{title="Analysis"  , info="Line1\nLine2\nLine3", action=pushanalysis  },
{title="FormulaPro", info="Line1\nLine2\nLine3", action=pushformulapro},
{title="Reference" , info="Line1\nLine2\nLine3", action=pushreference }
}

function main:paint(gc)
	gc:setFont("sansserif", "b", 12)
	gc:drawString("EEPro for the Nspire", 5, 2, "top")
	gc:drawString("v0.0.2", 170, 2, "top")

	gc:setFont("sansserif", "r", 10)
	
	local number_items	= #self.items
	local item_H	= 48
	local item_W	= 270
	local item_S	= 5
	local startY	= (self.h - (item_H + item_S) * number_items)/2 + 3
	local startX	= (self.w - item_W)/2
	
	for n, item in ipairs(self.items) do
		local y	= startY + (item_H + item_S) * (n - 1)
		
		if self.items[n].icon then
			gc:drawImage(self.items[n].icon, startX, y)
		end
		
		if self.sel~=n then
			gc:setColorRGB(220, 220, 220)
		else
			gc:setColorRGB(0,0,0)			
			gc:drawRect(startX-1, y-1, item_W+2, item_H+2)
		end
		gc:drawRect(startX, y, item_W, item_H)
		

		
		gc:setColorRGB(0, 0, 0)
		gc:setFont("sansserif", "r", 10)
		gc:drawString(self.items[n].title, startX+item_H+10, y, "top")
		
		gc:setColorRGB(128, 128, 128)
		gc:setFont("sansserif", "r", 8)

		local splinfo	= self.items[n].info:split("\n")
		
		for i, str in ipairs(splinfo) do
			gc:drawString(str, startX+item_H+10, y + 15 + i*10-10, "top")
		end

	end
	
	nativeBar(gc, self, 25)
	nativeBar(gc, self, self.h-26)
end

function main:arrowKey(arrow)
	if arrow == "up" and self.sel>1 then
		self.sel	= self.sel-1
	elseif arrow == "down" and self.sel<#self.items then
		self.sel	= self.sel+1
	end
	self:invalidate()
end

function main:enterKey()
	self.items[self.sel].action()
end

push_screen(main)
main.items[1].icon	= image.new("\048\000\000\000\048\000\000\000\000\000\000\000\096\000\000\000\016\000\001\000alalalalalalalalalalalalal\222\251\156\243\123\239\090\235\057\231\057\231\090\235\123\239\156\243\222\251alalalalalalalalalalalalalalalalalalalalalalalalalalalalalalalalalalalal\156\243\057\231\024\227\090\235\156\243\222\251\222\251\222\251\222\251\156\243\090\235\024\227\057\231\156\243alalalalalalalalalalalalalalalalalalalalalalalalalalalalalalalal\156\243\024\227\090\235\222\251alal\156\243\057\231\024\227\024\227\057\231\156\243alal\222\251\090\235\024\227\156\243alalalalalalalalalalalalalalalalalalalalalalalalalalalal\222\251\057\231\057\231\222\251al\123\239\115\206\206\185\107\173\107\173\107\173\107\173\107\173\140\177\239\189\148\210\123\239alal\057\231\057\231\222\251alalalalalalalalalalalalalalalalalalalalalalalalal\222\251\024\227\123\239al\123\239\082\202\140\177\140\177\239\189\082\202\181\214\214\218\214\218\214\218\148\210\016\194\173\181\140\177\082\202\156\243al\156\243\247\222\189\247alalalalalalalalalalalalalalalalalalalalalalal\222\251\247\222\189\247al\214\218\173\181\206\185\082\202\024\227\189\247alalalalalal\222\251\123\239\181\214\206\185\173\181\247\222al\189\247\247\222\189\247alalalalalalalalalalalalalalalalalalalalal\222\251\247\222\156\243al\115\206\173\181\049\198\024\227\222\251alalal\222\251\222\251\222\251\222\251alalalal\123\239\115\206\173\181\181\214al\189\247\247\222\222\251alalalalalalalalalalalalalalalalalalalal\024\227\123\239al\148\210\206\185\115\206\123\239al\222\251\222\251\222\251\222\251\222\251\222\251\222\251\222\251\222\251\222\251\222\251\222\251al\222\251\214\218\206\185\214\218al\123\239\024\227alalalalalalalalalalalalalalalalalalal\156\243\024\227al\024\227\206\185\115\206\123\239\222\251\222\251\222\251\222\251\222\251\222\251\222\251\222\251\222\251\222\251\222\251\222\251\222\251\222\251\222\251\222\251\222\251\214\218\206\185\057\231al\024\227\123\239alalalalalalalalalalalalalalalalalal\247\222\189\247\189\247\016\194\082\202\090\235\222\251\189\247\189\247\189\247\189\247\189\247\189\247\189\247\189\247\189\247\189\247\189\247\189\247\189\247\189\247\189\247\189\247\189\247\189\247\148\210\016\194\189\247\222\251\214\218alalalalalalalalalalalalalalalalal\156\243\024\227al\181\214\016\194\247\222\189\247\189\247\189\247\189\247\189\247\189\247\189\247\189\247\189\247\189\247\189\247\189\247\189\247\189\247\189\247\189\247\189\247\189\247\189\247\189\247\123\239\049\198\214\218al\024\227\123\239alalalalalalalalalalalalalalalal\247\222\189\247\189\247\049\198\115\206\123\239\189\247\156\243\189\247\189\247\189\247\156\243\156\243\123\239\123\239\090\235\090\235\090\235\123\239\123\239\156\243\156\243\189\247\189\247\156\243\156\243\189\247\214\218\049\198\222\251\189\247\247\222alalalalalalalalalalalalalalal\222\251\214\218al\024\227\049\198\247\222\156\243\156\243\156\243\123\239\090\235\024\227\247\222\247\222\214\218\214\218\214\218\214\218\214\218\214\218\214\218\214\218\247\222\024\227\090\235\156\243\156\243\156\243\123\239\049\198\057\231al\214\218\222\251alalalalalalalalalalalalalal\156\243\247\222al\181\214\082\202\090\235\156\243\090\235\024\227\214\218\214\218\214\218\247\222\247\222\247\222\024\227\024\227\024\227\024\227\247\222\247\222\247\222\214\218\214\218\181\214\214\218\024\227\123\239\156\243\148\210\214\218al\024\227\123\239alalalalalalalalalalalalalal\090\235\090\235al\115\206\148\210\090\235\247\222\181\214\181\214\214\218\247\222\024\227\024\227\024\227\024\227\057\231\057\231\057\231\057\231\024\227\024\227\024\227\024\227\247\222\214\218\214\218\181\214\181\214\024\227\214\218\148\210al\090\235\057\231alalalalalalalalalalalalalal\024\227\123\239\222\251\115\206\148\210\181\214\181\214\214\218\247\222\247\222\024\227\024\227\057\231\057\231\090\235\090\235\090\235\090\235\090\235\090\235\057\231\057\231\024\227\024\227\247\222\247\222\214\218\181\214\148\210\148\210\148\210al\123\239\247\222alalalalalalalalalalalalalal\247\222\156\243\189\247\115\206\181\214\181\214\214\218\247\222\024\227\024\227\057\231\057\231\090\235\090\235\090\235\123\239\123\239\123\239\123\239\090\235\090\235\090\235\057\231\057\231\024\227\024\227\247\222\214\218\181\214\181\214\148\210\222\251\156\243\247\222alalalalalalalalalalalalalal\247\222\123\239\222\251\148\210\181\214\214\218\247\222\024\227\024\227\057\231\090\235\090\235\123\239\123\239\123\239\123\239\123\239\123\239\123\239\123\239\123\239\123\239\090\235\090\235\057\231\024\227\024\227\247\222\214\218\181\214\181\214\222\251\156\243\247\222alalalalalalalalalalalalalal\247\222\123\239\222\251\181\214\214\218\247\222\024\227\024\227\057\231\090\235\123\239\123\239\123\239\123\239\123\239\156\243\156\243\156\243\156\243\123\239\123\239\123\239\123\239\090\235\090\235\057\231\024\227\024\227\247\222\181\214\214\218al\123\239\247\222alalalalalalalalalalalalalal\057\231\024\227al\247\222\214\218\247\222\024\227\057\231\090\235\090\235\123\239\123\239\156\243\156\243\156\243\156\243\156\243\156\243\156\243\156\243\156\243\156\243\123\239\123\239\090\235\090\235\057\231\024\227\247\222\214\218\247\222al\057\231\024\227alalalalalalalalalalalalalal\156\243\214\218al\057\231\214\218\024\227\057\231\090\235\090\235\123\239\123\239\156\243\156\243\156\243\156\243\156\243\156\243\156\243\156\243\156\243\156\243\156\243\156\243\123\239\123\239\090\235\090\235\057\231\024\227\214\218\090\235al\214\218\123\239alalalalalalalalalalalalalal\222\251\148\210\222\251\156\243\214\218\057\231\090\235\123\239\123\239\123\239\156\243\156\243\156\243\156\243\156\243\156\243\156\243\156\243\156\243\156\243\156\243\156\243\156\243\156\243\123\239\123\239\123\239\090\235\057\231\214\218\189\247al\148\210\222\251alalalalalalalalalalalalalalal\181\214\123\239al\024\227\024\227\123\239\156\243\156\243\156\243\156\243\156\243\156\243\156\243\156\243\156\243\156\243\156\243\156\243\156\243\156\243\156\243\156\243\156\243\156\243\156\243\123\239\123\239\024\227\024\227al\123\239\181\214alalalalalalalalalalalalalalalal\123\239\181\214al\123\239\024\227\123\239\156\243\189\247\189\247\189\247\189\247\156\243\156\243\156\243\156\243\156\243\156\243\156\243\156\243\156\243\156\243\189\247\189\247\189\247\189\247\156\243\123\239\024\227\156\243al\181\214\090\235alalalalalalalalalalalalalalalalal\148\210\123\239al\057\231\057\231\156\243\222\251\222\251\222\251\222\251\222\251\189\247\189\247\189\247\189\247\189\247\189\247\189\247\189\247\222\251\222\251\222\251\222\251\222\251\189\247\057\231\090\235al\156\243\082\202\222\251alalalalalalalalalalalalalalalalal\123\239\115\206al\222\251\057\231\123\239\189\247\222\251\222\251\222\251\222\251\222\251\222\251\222\251\222\251\222\251\222\251\222\251\222\251\222\251\222\251\222\251\222\251\222\251\123\239\057\231\222\251al\148\210\247\222alalalalalalalalalalalalalalalalalalal\181\214\247\222al\189\247\057\231\123\239\222\251alalalalalalalalalalalalalal\222\251\123\239\057\231\189\247al\024\227\016\194\222\251alalalalalalalalalalalalalalalalalalalal\115\206\057\231al\189\247\090\235\123\239\189\247\222\251alalalalalalalalalalal\189\247\123\239\090\235\189\247al\057\231\206\185\090\235alalalalalalalalalalalalalalalalalalalalal\189\247\082\202\057\231al\222\251\123\239\090\235\123\239\189\247\222\251alalalalalal\222\251\189\247\123\239\090\235\123\239\222\251al\057\231\082\202\247\222\115\206\173\181\148\210alalalalalalalalalalalalalalalalalalalal\189\247\082\202\247\222alal\189\247\123\239\123\239\123\239\156\243\156\243\189\247\189\247\156\243\156\243\123\239\123\239\123\239\189\247alal\247\222\239\189\214\218\016\194\066\136\132\144\033\132\206\185alalalalalalalalalalalalalalalalalalalal\222\251\115\206\082\202\123\239alal\222\251\189\247\156\243\123\239\123\239\123\239\123\239\156\243\189\247\222\251alal\123\239\082\202\074\169\082\202\107\173\000\128\107\173\024\227\140\177\033\132\206\185alalalalalalalalalalalalalalalalalalalalal\247\222\239\189\115\206\090\235\189\247alalalalalalalal\189\247\090\235\148\210\140\177\173\181\024\227\140\177\066\136\033\132\074\169\181\214\123\239\140\177\033\132\206\185alalalalalalalalalalalalalalalalalalalalal\189\247\148\210\173\181\206\185\115\206\247\222\057\231\090\235\090\235\057\231\247\222\115\206\206\185\074\169\140\177\181\214\222\251al\008\161\066\136\099\140\099\140\074\169\148\210\090\235\140\177\033\132\206\185alalalalalalalalalalalalalalalalalalalalalal\222\251\024\227\082\202\206\185\107\173\140\177\107\173\107\173\107\173\206\185\082\202\057\231alalalal\074\169\066\136\132\144\099\140\066\136\074\169\115\206\057\231\140\177\033\132\206\185alalalalalalalalalalalalalalalalalalalalalalalalal\222\251\189\247\156\243\189\247\222\251alalalalalalal\090\235\165\148\066\136\132\144\099\140\066\136\041\165\115\206\024\227\107\173\033\132\206\185alalalalalalalalalalalalalalalalalalalalalalalalalalalalalalalalalalalalal\057\231\165\148\066\136\132\144\099\140\066\136\041\165\082\202\247\222\107\173\033\132\206\185alalalalalalalalalalalalalalalalalalalalalalalalalalalalalalalalalalalalal\057\231\165\148\066\136\132\144\099\140\066\136\041\165\049\198\214\218\074\169\033\132\206\185alalalalalalalalalalalalalalalalalalalalalalalalalalalalalalalalalalalalal\057\231\165\148\066\136\132\144\099\140\066\136\041\165\016\194\148\210\041\165\033\132\206\185alalalalalalalalalalalalalalalalalalalalalalalalalalalalalalalalalalalalal\057\231\165\148\066\136\165\148\132\144\066\136\008\161\239\189\115\206\041\165\033\132\206\185alalalalalalalalalalalalalalalalalalalalalalalalalalalalalalalalalalalalal\057\231\165\148\066\136\165\148\132\144\066\136\008\161\206\185\049\198\008\161\033\132\206\185alalalalalalalalalalalalalalalalalalalalalalalalalalalalalalalalalalalalal\057\231\165\148\066\136\165\148\132\144\066\136\231\156\173\181\016\194\231\156\033\132\115\206alalalalalalalalalalalalalalalalalalalalalalalalalalalalalalalalalalalalal\057\231\165\148\066\136\165\148\132\144\066\136\231\156\140\177\107\173\066\136\107\173alalalalalalalalalalalalalalalalalalalalalalalalalalalalalalalalalalalalalal\057\231\165\148\066\136\198\152\132\144\066\136\165\148\132\144\066\136\115\206alalalalalalalalalalalalalalalalalalalalalalalalalalalalal\222\251\222\251\222\251\222\251\189\247\189\247\156\243\156\243\156\243\189\247\214\218\132\144\066\136\198\152\132\144\066\136\066\136\206\185alalalalalalalalalalalalalalalalalalalalalalalalal\222\251\222\251\189\247\156\243\156\243\123\239\090\235\057\231\024\227\247\222\247\222\214\218\181\214\148\210\115\206\148\210\239\189\099\140\099\140\132\144\066\136\140\177\222\251alalalalalalalalalalalalalalalalalalalalalalalal\222\251\222\251\189\247\156\243\123\239\090\235\057\231\024\227\247\222\214\218\181\214\148\210\115\206\082\202\049\198\049\198\016\194\016\194\173\181\165\148\099\140\107\173\057\231\189\247alalalalalalalalalalalalalalalalalalalalalalalalalal\222\251\222\251\189\247\189\247\156\243\156\243\123\239\090\235\057\231\057\231\024\227\247\222\214\218\214\218\181\214\181\214\181\214\181\214\214\218\057\231\156\243\222\251alalalalalalalalalalalalalalalalalalalalalalalalalalalalalalalalalal\222\251\222\251\222\251\222\251\222\251\222\251\222\251\189\247\189\247\222\251\222\251\222\251alalalalal")
main.items[2].icon	= image.new("\048\000\000\000\048\000\000\000\000\000\000\000\096\000\000\000\016\000\001\000\024\231\173\181\206\185\206\185\206\185\206\185\206\185\173\181\239\189\049\198\016\194\016\198\016\198\016\198\049\198\049\198\049\198\049\198\049\198\049\198\049\198\049\198\049\198\049\198\049\198\049\198\049\198\049\198\082\202\115\206\115\206\115\206\115\206\115\206\115\206\115\206\115\206\115\206\115\206\115\206\115\206\115\206\115\206\082\202\082\202\082\202\115\206\123\239\173\181\000\128\000\128\000\128\000\128\000\128\000\128\000\128\000\128\000\128\000\128\000\128\000\128\000\128\000\128\000\128\000\128\000\128\000\128\000\128\000\128\000\128\000\128\000\128\000\128\000\128\000\128\000\128\000\128\000\128\000\128\000\128\000\128\000\128\000\128\000\128\000\128\000\128\000\128\000\128\000\128\000\128\000\128\000\128\000\128\000\128\000\128\016\194\206\185\000\128\214\206\090\223\090\219\090\223\090\219\090\219\090\219\090\219\090\219\090\219\089\219\090\219\057\215\057\223\057\227\057\223\057\227\057\223\024\215\024\219\024\219\024\219\057\219\057\219\057\219\024\215\024\215\057\219\024\215\057\219\024\219\024\215\024\215\057\219\024\215\024\215\024\219\024\215\024\215\024\215\057\219\056\215\173\177\000\128\198\152\090\235\206\185\000\128\090\223\255\239\254\243\222\239\222\231\222\239\255\243\222\239\222\235\222\231\222\231\222\231\222\231\255\243\255\251\255\247\255\251\255\247\222\235\222\239\222\235\222\239\222\239\222\239\254\239\222\239\222\239\255\239\222\239\222\235\222\235\222\235\222\235\222\239\222\239\222\235\222\235\222\235\222\239\255\243\255\239\148\198\000\128\000\128\057\231al\206\185\000\128\057\219\222\235\189\235\189\231\189\231\189\235\189\235\189\231\189\227\189\227\189\227\189\227\189\227\222\239\222\247\222\243\222\247\222\243\189\231\189\231\189\235\189\235\189\231\189\235\189\235\189\235\189\235\189\231\189\231\189\231\189\231\189\231\189\231\189\231\189\235\189\235\189\231\189\231\189\235\222\239\082\194\000\128\000\128\024\227alal\206\185\000\128\090\223\222\235\189\227\189\231\189\231\189\231\189\231\189\227\189\227\189\231\189\231\189\227\188\227\222\239\222\247\222\243\222\247\222\243\189\231\189\231\189\235\189\235\189\235\189\235\189\235\189\235\189\231\189\231\189\231\189\231\189\235\189\235\189\235\189\235\222\235\189\235\189\235\222\235\222\235\082\194\000\128\000\128\024\227alalal\206\185\000\128\057\219\222\235\189\235\189\231\189\231\189\231\222\235\222\235\222\235\222\231\222\231\222\231\222\231\255\243\255\251\255\247\255\251\255\247\222\235\222\235\222\235\222\235\222\235\222\235\222\235\221\235\189\235\189\231\221\235\189\231\189\235\222\235\221\235\189\235\189\231\189\231\189\235\221\231\082\190\000\128\000\128\247\222alalalal\206\185\000\128\056\215\222\235\189\231\189\231\189\231\189\231\057\219\024\215\057\219\090\223\090\219\090\219\090\219\123\231\123\235\123\231\123\235\123\231\123\223\123\227\123\227\123\227\123\227\156\227\156\227\156\231\222\235\222\239\222\239\189\235\189\231\189\231\189\231\189\231\189\231\189\231\222\231\082\190\000\128\000\128\182\214alalalalal\206\185\000\128\057\215\222\235\189\231\189\231\222\235\024\215\000\128\000\128\000\128\000\128\000\128\000\128\000\128\000\128\000\128\000\128\000\128\000\128\000\128\000\128\000\128\000\128\000\128\132\132\008\157\041\161\148\202\222\239\222\239\189\235\189\231\189\235\189\231\189\231\221\235\222\235\082\194\000\128\000\128\181\214alalalalalal\206\185\000\128\057\215\222\235\189\231\189\235\222\235\214\206\000\128\198\148\206\185\016\194\239\189\173\181\206\185\206\185\206\185\206\185\206\185\206\185\206\185\173\185\206\185\173\181\173\185\206\185\132\148\000\128\000\128\090\223\222\235\189\231\189\231\189\231\189\231\222\235\222\239\082\194\000\128\000\128\148\210alalalalalalal\206\185\000\128\057\215\222\235\189\231\189\231\222\235\214\206\000\128\140\177alalalalalalalalalalalalalalal\247\222\099\136\000\128\049\186\189\235\222\235\189\231\189\231\189\231\221\235\222\235\082\198\000\128\000\128\148\210alalalalalalalal\206\185\000\128\057\215\222\235\189\231\189\231\222\239\214\206\000\128\173\181alalalalalalalalalalalalalal\057\231\066\136\000\128\016\182\189\231\222\231\189\231\189\231\189\231\189\231\222\235\049\190\000\128\000\128\148\210alalalalalalalalal\206\185\000\128\057\219\222\239\189\231\189\235\255\243\247\210\000\128\140\177alalalalalalalalalalalalal\057\231\066\132\000\128\016\186\189\231\222\235\189\231\189\231\189\231\189\231\189\231\082\190\000\128\000\128\115\206alalalalalalalalalal\206\185\000\128\057\219\222\239\189\231\189\231\222\235\214\206\000\128\173\181alalalalalalalalalalalal\090\235\165\144\000\128\239\181\189\231\222\235\189\231\189\231\189\231\222\235\189\235\049\190\000\128\000\128\082\202alalalalalalalalalalal\206\185\000\128\057\219\222\235\189\231\189\231\222\235\214\206\000\128\239\189alalalalalalalalalalal\123\239\198\148\000\128\206\181\189\231\222\235\189\231\189\231\189\227\189\231\189\231\049\190\000\128\000\128\115\206alalalalalalalalalalalal\206\185\000\128\057\215\222\235\189\231\189\231\222\235\214\206\000\128\016\194alalalalalalalalalal\123\239\231\156\000\128\206\177\156\231\222\235\189\231\189\231\189\231\189\231\189\231\016\186\000\128\000\128\115\206alalalalalalalalalalalalal\206\185\000\128\057\223\255\243\222\239\189\239\255\243\247\210\000\128\239\189alalalalalalalalal\156\243\041\165\000\128\206\181\189\235\222\239\189\239\222\239\189\239\222\239\189\235\016\186\000\128\000\128\115\206alalalalalalalalalalalalalal\206\185\000\128\058\227\255\247\222\243\222\243\255\247\247\218\000\128\016\194alalalalalalalal\189\247\107\173\000\128\206\181\189\239\255\247\222\243\222\243\222\243\222\243\222\243\049\194\000\128\000\128\148\210alalalalalalalalalalalalalalal\206\185\000\128\057\227\255\247\222\239\222\239\255\247\247\214\000\128\016\190alalalalalalal\222\251\173\181\000\128\140\173\189\239\255\247\222\243\222\243\222\243\255\247\222\243\049\194\000\128\000\128\148\210alalalalalalalalalalalalalalalal\206\185\000\128\090\231\255\251\222\247\222\247\255\251\247\218\000\128\016\194alalalalalal\222\251\173\181\000\128\074\169\156\239\255\251\222\247\223\247\222\247\255\251\222\247\016\190\000\128\000\128\181\214alalalalalalalalalalalalalalalalal\206\185\000\128\057\223\255\243\222\243\222\243\255\251\247\218\000\128\016\194alalalalal\222\251\206\185\000\128\041\165\123\235\255\243\222\239\222\243\222\239\222\243\222\239\049\194\000\128\000\128\181\214alalalalalalalalalalalalalalalalalal\206\185\000\128\057\219\222\235\189\235\189\235\255\239\247\210\000\128\239\189alalalalal\239\189\000\128\041\161\123\235\255\247\189\235\222\239\189\235\222\239\222\239\240\185\000\128\000\128\181\214alalalalalalalalalalalalalalalalalalal\206\185\000\128\057\223\255\243\189\235\189\235\255\243\247\214\000\128\049\198alalalal\049\198\000\128\008\161\123\227\255\251\222\243\222\239\190\239\222\239\222\243\016\194\000\128\000\128\247\222alalalalalalalalalalalalalalalalalalalal\206\185\000\128\057\223\255\243\189\235\190\239\255\243\247\210\000\128\082\202alalal\082\202\000\128\231\156\090\231\255\247\222\243\222\243\189\235\222\239\189\239\049\190\000\128\000\128\024\227alalalalalalalalalalalalalalalalalalalalal\206\185\000\128\057\223\222\239\189\231\189\235\255\239\214\210\000\128\049\198alal\115\202\000\128\198\148\090\227\255\251\222\239\222\247\222\243\222\239\222\239\016\186\000\128\066\132\024\227alalalalalalalalalalalalalalalalalalalalalal\206\185\000\128\057\219\222\239\189\231\189\231\222\239\214\210\000\128\082\202al\148\210\000\128\198\148\057\219\255\247\222\247\222\243\222\247\222\243\189\239\016\190\000\128\132\144\057\231alalalalalalalalalalalalalalalalalalalalalalal\206\185\000\128\057\219\255\239\189\235\189\235\255\239\214\210\000\128\115\206\214\218\000\128\099\140\056\215\222\235\222\243\223\247\222\239\255\247\222\243\016\186\000\128\198\152\090\235alalalalalalalalalalalalalalalalalalalalalalalal\206\185\000\128\057\219\222\239\189\239\189\239\255\239\214\206\000\128\041\165\000\132\000\128\024\211\222\235\189\227\222\239\222\247\222\243\222\243\016\190\000\128\008\161\123\239alalalalalalalalalalalalalalalalalalalalalalalalal\206\185\000\128\057\219\255\243\190\239\189\235\222\239\214\210\000\128\000\128\000\128\247\210\222\235\189\231\189\231\222\239\255\251\222\243\016\190\000\128\041\165\123\239alalalalalalalalalalalalalalalalalalalalalalalalalal\206\185\000\128\057\223\255\243\189\235\189\231\222\239\247\210\000\128\000\128\214\206\222\239\189\235\189\231\189\227\222\243\222\247\016\190\000\128\107\173\189\247alalalalalalalalalalalalalalalalalalalalalalalalalalal\206\185\000\128\024\219\255\239\189\231\189\231\189\231\156\227\181\202\247\210\222\231\189\231\189\231\189\227\189\231\189\239\016\190\000\128\107\173\189\247alalalalalalalalalalalalalalalalalalalalalalalalalalalal\206\185\000\128\247\210\222\239\189\235\189\231\189\231\189\235\222\235\222\235\189\231\189\227\189\227\221\231\156\227\239\185\000\128\074\169\189\247alalalalalalalalalalalalalalalalalalalalalalalalalalalalal\206\185\000\128\247\210\255\239\189\231\189\235\221\235\189\231\189\231\189\231\189\231\189\231\189\231\188\227\239\181\000\128\107\173\189\247alalalalalalalalalalalalalalalalalalalalalalalalalalalalalal\206\185\000\128\247\214\222\239\189\231\189\235\189\235\189\227\189\227\189\231\189\231\222\231\189\231\239\181\000\128\140\177\189\247alalalalalalalalalalalalalalalalalalalalalalalalalalalalalalal\206\185\000\128\024\219\255\243\189\235\189\231\189\231\189\231\189\231\189\231\221\231\156\227\206\177\000\128\140\177\189\247alalalalalalalalalalalalalalalalalalalalalalalalalalalalalalalal\206\185\000\128\024\219\255\243\189\235\189\231\189\231\190\235\189\231\221\231\156\227\239\181\000\128\173\181\222\251alalalalalalalalalalalalalalalalalalalalalalalalalalalalalalalalal\206\185\000\128\247\210\222\235\189\235\189\235\189\235\189\235\221\231\156\227\206\177\000\128\173\181\222\251alalalalalalalalalalalalalalalalalalalalalalalalalalalalalalalalalal\206\185\000\128\247\210\222\235\189\231\189\231\189\231\222\231\156\227\206\177\000\128\206\181\222\251alalalalalalalalalalalalalalalalalalalalalalalalalalalalalalalalalalal\206\185\000\128\247\210\222\235\189\231\189\231\222\235\156\227\206\177\000\128\173\181\189\247alalalalalalalalalalalalalalalalalalalalalalalalalalalalalalalalalalalal\206\185\000\128\247\210\222\239\190\239\222\239\156\227\206\181\000\128\173\181\222\251alalalalalalalalalalalalalalalalalalalalalalalalalalalalalalalalalalalalal\206\185\000\128\247\210\222\235\222\235\156\227\206\177\000\128\107\173\189\247alalalalalalalalalalalalalalalalalalalalalalalalalalalalalalalalalalalalalal\206\185\000\128\247\214\255\239\156\227\174\177\000\128\041\165\156\243alalalalalalalalalalalalalalalalalalalalalalalalalalalalalalalalalalalalalalal\206\185\000\128\024\215\189\231\206\181\000\128\041\165\156\243alalalalalalalalalalalalalalalalalalalalalalalalalalalalalalalalalalalalalalalal\206\185\000\128\213\206\016\186\000\128\041\161\156\243alalalalalalalalalalalalalalalalalalalalalalalalalalalalalalalalalalalalalalalalal\206\185\000\128\008\161\000\128\008\157\123\239alalalalalalalalalalalalalalalalalalalalalalalalalalalalalalalalalalalalalalalalalal\206\185\000\128\000\128\231\156\123\239alalalalalalalalalalalalalalalalalalalalalalalalalalalalalalalalalalalalalalalalalalal\206\185\000\128\132\144\090\235alalalalalalalalalalalalalalalalalalalalalalalalalalalalalalalalalalalalalalalalalalalal\115\206\000\128\057\231alalalalalalalalalalalalalalalalalalalalalalalalalalalalalalalalalalalalalalalalalalalalal")
main.items[3].icon	= image.new("\048\000\000\000\048\000\000\000\000\000\000\000\096\000\000\000\016\000\001\000alalalalalalalalalalal\189\247alal\189\247alal\222\251alalal\255\127\255\127alalalalalalalalalal\255\127\255\127\255\127alalalalalalalalalalalalalalalalalalalalal\222\251alalal\181\214\148\210alalal\255\127\222{\222{\255\127\222{\255\127\255\127\255\127\255\127\255\127al\255\127\255\127\255\127\255\127\255\127\255\127\255\127\255\127\255\127\255\127\255\127\255\127\255\127\255\127al\255\127\255\127al\255\127alalalalalalalalalalalal\222\251\107\173\066\136\008\161\057\231alal\222\251\255\127\255\127al\222\251al\255\127\255\127\255\127\255\127\255\127\255\127\255\127al\255\127\255\127\255\127\255\127al\255\127al\255\127\255\127\255\127\255\127alalalalalalalalalalalal\222\251alalalal\074\169\000\128\132\144\066\136\214\218\222\251alal\255\127\255\127\255\127\255\127\255\127\255\127\255\127al\255\127\255\127\255\127\255\127\255\127al\255\127\255\127al\255\127al\255\127alalalalalalalalalalalalalalalalalalalal\008\161\074\169\024\227\173\181\066\136\115\206al\222{\255\127\222{al\255\127alalal\255\127alalal\255\127\255\127\255\127\255\127alalalalalalalalalalalalalalalalalalalalalal\222\251al\189\247\099\140\206\185\255\255\255\255\115\206\132\144\206\185\156\243alalalalalalalalalalalalalal\255\127\255\127alalalalalalalalalalalalalalalalalalalalalalal\189\247\132\144\239\189\255\255\255\255\255\255\024\227\165\148\008\161\189\247alalalalalalalalalalalalalalalalalalalalalalalalalalalalalalalalalalalalalal\156\243\132\144\082\202\255\255\255\255\255\255\255\255\156\243\074\169\074\169\156\243alalalalalalalalalalalalalalalalalalalalalalalalalalal\222\251alal\222\251alalalalalal\057\231\132\144\115\206\255\255\255\255\255\255\255\255\255\255\123\239\041\165\140\177alal\222\251\222\251al\222\251al\222\251alal\222\251al\222\251alal\222\251alalalalalal\222\251alal\222\251alal\222\251\222\251al\156\243\115\206\107\173\107\173\140\177\107\173\107\173\000\128\115\206\255\255\255\255\255\255\255\255\255\255\255\255\247\222\231\156\148\210alalalalalalalal\222\251\024\227\115\206\140\177\008\161\231\156\008\161\008\161\049\198\090\235alal\222\251alalalalal\222\251\222\251al\057\231\173\181\198\152\000\128\008\161\239\189\206\185\074\169\000\128\148\210\255\255\255\255\255\255\255\255\255\255\255\255\255\255\016\194\008\161\222\251\222\251\222\251alalal\090\235\016\194\132\144\099\140\198\152\041\165\140\177\173\181\074\169\000\128\066\136\206\185\156\243al\222\251alal\222\251alal\222\251al\090\235\206\185\016\194\115\206\000\128\115\206\255\255\222\251\049\198\066\136\214\218\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\074\169\148\210alal\222\251\057\231\239\189\074\169\041\165\049\198\214\218\123\239\222\251\255\255\255\255\123\239\041\165\132\144\107\173\016\194\189\247\222\251alalalal\222\251alal\140\177\041\165\156\243\115\206\000\128\214\218\255\255\255\255\239\189\033\132\024\227\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\214\218\099\140\057\231\189\247\107\173\132\144\049\198\189\247\222\251\189\247\255\255\255\255\255\255\255\255\255\255\222\251\173\181\165\148\016\194\008\161\148\210al\222\251\222\251al\222\251\222\251al\222\251\008\161\016\194\255\255\140\177\033\132\057\231\255\255\255\255\206\185\033\132\156\243\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\156\243\099\140\198\152\008\161\140\177\090\235\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\082\202\033\132\082\202\107\173\016\194alalalalalalal\090\235\165\148\148\210\222\251\206\185\066\136\123\239\255\255\255\255\140\177\033\132\123\239\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\189\247\165\148\033\132\049\198\156\243\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\214\218\099\140\016\194\239\189\173\181\189\247alalal\222\251\222\251al\247\222\066\136\090\235\255\255\140\177\132\144\123\239\255\255\222\251\107\173\132\144\222\251\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\008\161\041\165\189\247\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\247\222\132\144\173\181\016\194\074\169alal\222\251alalalal\082\202\132\144\189\247\255\255\107\173\198\152\222\251\255\255\222\251\198\152\198\152\189\247\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\156\243\165\148\082\202\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\156\243\132\144\107\173\082\202\008\161\123\239\222\251al\222\251alalal\016\194\165\148\189\247\255\255\041\165\008\161\255\255\255\255\222\251\198\152\231\156\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\156\243\099\140\082\202\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\189\247\198\152\074\169\082\202\231\156\024\227alalalalalal\140\177\231\156\222\251\255\255\231\156\074\169\255\255\255\255\189\247\165\148\041\165\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\123\239\099\140\082\202\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\222\251\041\165\041\165\082\202\231\156\181\214alalalalalal\231\156\041\165\255\255\255\255\198\152\140\177\255\255\255\255\156\243\132\144\074\169\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\123\239\132\144\148\210\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\107\173\231\156\115\206\008\161\016\194alalalalal\156\243\099\140\140\177\255\255\255\255\198\152\206\185\255\255\255\255\156\243\099\140\140\177\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\123\239\165\148\181\214\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\206\185\165\148\115\206\074\169\173\181alalalalal\090\235\033\132\206\185\255\255\255\255\231\156\239\189\255\255\255\255\156\243\066\136\140\177\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\123\239\165\148\214\218\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\049\198\132\144\082\202\173\181\041\165\222\251alalalal\024\227\033\132\049\198\255\255\255\255\198\152\049\198\255\255\255\255\156\243\033\132\173\181\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\156\243\165\148\214\218\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\148\210\165\148\082\202\239\189\198\152\156\243alalalal\214\218\033\132\115\206\255\255\222\251\198\152\082\202\255\255\255\255\156\243\033\132\173\181\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\156\243\132\144\214\218\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\247\222\165\148\082\202\016\194\132\144\090\235alal\222\251al\082\202\033\132\247\222\255\255\222\251\165\148\148\210\255\255\255\255\156\243\033\132\140\177\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\123\239\165\148\214\218\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\090\235\165\148\016\194\049\198\198\152\115\206alalalal\206\185\033\132\057\231\255\255\189\247\165\148\181\214\255\255\255\255\123\239\066\136\173\181\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\189\247\165\148\214\218\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\123\239\165\148\239\189\082\202\231\156\082\202alalalal\107\173\099\140\123\239\255\255\123\239\198\152\181\214\255\255\255\255\090\235\066\136\231\156\090\235\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\123\239\165\148\214\218\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\189\247\198\152\173\181\115\206\008\161\016\194alalalal\074\169\165\148\189\247\255\255\090\235\231\156\057\231\255\255\255\255\090\235\132\144\000\128\231\156\173\181\057\231\255\255\255\255\255\255\255\255\255\255\255\255\255\255\165\148\214\218\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\222\251\008\161\074\169\148\210\074\169\206\185alalalal\008\161\198\152\189\247\255\255\090\235\231\156\057\231\255\255\255\255\255\255\247\222\239\189\041\165\132\144\132\144\082\202\189\247\255\255\255\255\255\255\255\255\123\239\165\148\214\218\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\222\251\107\173\008\161\115\206\173\181\173\181\222\251alal\189\247\132\144\008\161\222\251\255\255\057\231\165\148\156\243\255\255\255\255\255\255\255\255\255\255\222\251\123\239\016\194\099\140\198\152\024\227\255\255\255\255\255\255\156\243\132\144\214\218\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\206\185\165\148\082\202\239\189\107\173\189\247alal\123\239\033\132\107\173\255\255\255\255\024\227\165\148\090\235\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\123\239\074\169\132\144\049\198\222\251\255\255\156\243\132\144\214\218\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\082\202\132\144\049\198\049\198\074\169\123\239alal\090\235\033\132\206\185\255\255\222\251\247\222\198\152\156\243\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\222\251\049\198\099\140\173\181\222\251\189\247\132\144\214\218\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\148\210\099\140\016\194\082\202\041\165\090\235alal\247\222\000\128\082\202\255\255\222\251\115\206\041\165\222\251\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\222\251\255\255\214\218\231\156\173\181\189\247\132\144\214\218\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\214\218\132\144\239\189\082\202\008\161\024\227alal\148\210\000\128\148\210\255\255\255\255\115\206\132\144\247\222\057\231\156\243\255\255\255\255\255\255\255\255\255\255\255\255\255\255\222\251\255\255\255\255\115\206\198\152\049\198\198\152\247\222\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\222\251\189\247\123\239\057\231\247\222\024\227\173\181\033\132\239\189\148\210\074\169\115\206alal\082\202\000\128\214\218\255\255\255\255\049\198\066\136\000\128\099\140\008\161\173\181\115\206\024\227\255\255\255\255\255\255\255\255\255\255\222\251\255\255\255\255\115\206\008\161\165\148\214\218\255\255\255\255\255\255\255\255\255\255\255\255\090\235\214\218\016\194\107\173\231\156\132\144\066\136\033\132\000\128\033\132\066\136\008\161\239\189\107\173\206\185alal\206\185\066\136\090\235\255\255\156\243\115\206\173\181\173\181\107\173\231\156\132\144\099\140\132\144\008\161\074\169\082\202\024\227\123\239\255\255\255\255\255\255\189\247\107\173\066\136\214\218\255\255\222\251\222\251\057\231\082\202\074\169\099\140\099\140\132\144\165\148\008\161\107\173\140\177\173\181\173\181\239\189\206\185\231\156\008\161\231\156\074\169alal\107\173\231\156\222\251\057\231\082\202\239\189\082\202\082\202\082\202\115\206\082\202\049\198\016\194\206\185\173\181\231\156\198\152\099\140\140\177\148\210\156\243\255\255\049\198\000\128\024\227\222\251\049\198\231\156\099\140\132\144\231\156\173\181\206\185\016\194\082\202\115\206\082\202\082\202\049\198\115\206\049\198\049\198\049\198\239\189\099\140\165\148alal\008\161\231\156\090\235\148\210\016\194\049\198\082\202\049\198\049\198\082\202\082\202\082\202\082\202\082\202\082\202\148\210\016\194\074\169\165\148\066\136\041\165\181\214\214\218\066\136\041\165\165\148\000\128\165\148\107\173\239\189\115\206\082\202\082\202\082\202\082\202\049\198\049\198\049\198\082\202\016\194\049\198\082\202\148\210\206\185\033\132\198\152\189\247\189\247\008\161\066\136\107\173\173\181\049\198\115\206\082\202\049\198\049\198\049\198\049\198\049\198\049\198\049\198\049\198\016\194\082\202\082\202\016\194\239\189\008\161\033\132\198\152\000\128\099\140\198\152\173\181\082\202\115\206\049\198\049\198\049\198\049\198\049\198\049\198\049\198\049\198\049\198\049\198\115\206\049\198\140\177\231\156\132\144\198\152\082\202\222\251al\214\218\140\177\099\140\099\140\231\156\140\177\049\198\082\202\082\202\082\202\082\202\082\202\082\202\082\202\082\202\115\206\082\202\016\194\049\198\082\202\082\202\173\181\099\140\000\128\008\161\049\198\148\210\049\198\016\194\049\198\049\198\082\202\049\198\049\198\049\198\082\202\082\202\049\198\016\194\074\169\132\144\165\148\206\185\247\222\222\251alal\222\251alal\123\239\082\202\074\169\165\148\132\144\165\148\008\161\173\181\049\198\082\202\082\202\082\202\082\202\082\202\049\198\049\198\049\198\049\198\082\202\082\202\173\181\000\128\231\156\082\202\082\202\049\198\016\194\082\202\016\194\082\202\082\202\082\202\082\202\016\194\140\177\231\156\132\144\008\161\049\198\123\239alalalalalalalalalalal\156\243\057\231\239\189\107\173\165\148\099\140\132\144\008\161\140\177\173\181\082\202\082\202\082\202\082\202\016\194\049\198\082\202\206\185\066\136\008\161\049\198\049\198\049\198\082\202\115\206\082\202\049\198\016\194\173\181\074\169\231\156\074\169\082\202\057\231\156\243\222\251alal\222\251\222\251alalal\222\251\222\251alalalal\222\251alal\156\243\181\214\173\181\198\152\066\136\066\136\099\140\231\156\173\181\049\198\049\198\082\202\082\202\016\194\099\140\008\161\049\198\082\202\082\202\049\198\206\185\107\173\198\152\165\148\008\161\016\194\057\231alalalalalalalalalal\222\251alalalal\222\251\222\251\222\251alal\222\251\222\251alal\189\247\247\222\115\206\041\165\132\144\000\128\033\132\198\152\206\185\049\198\239\189\000\128\041\165\115\206\082\202\140\177\231\156\165\148\165\148\239\189\214\218\189\247alal\222\251\222\251alalalalalalalalalal\222\251\222\251alalalalalalalalalalalalalal\247\222\140\177\099\140\000\128\000\128\066\136\099\140\000\128\132\144\041\165\165\148\000\128\165\148\082\202\189\247alalal\222\251alalalalalalalalalalalalalalalalalal\222\251\222\251alalalalalalalalalalal\057\231\016\194\008\161\066\136\000\128\000\128\000\128\132\144\107\173\181\214\222\251alal\222\251\222\251\222\251\222\251alalal\222\251\222\251\222\251alalalalalalalalalalalalalalalalalalalalalalal\222\251alalal\156\243\082\202\140\177\140\177\016\194\057\231\222\251alal\222\251alalalalalalalalalalalalalalalalalalalalalalalal\222\251\222\251alalalalalalalalalalalalalalalal\222\251alalalalalal\222\251alalalalalalalal\222\251\222\251alalalalal")
