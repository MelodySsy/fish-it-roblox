# 🤝 Contributing to Fish It

Terima kasih telah tertarik untuk berkontribusi pada Fish It script! 

## How to Contribute

### Reporting Bugs

Jika menemukan bug, silakan create GitHub Issue dengan:

1. **Descriptive Title**
   - Contoh: "Auto Fishing mode crashes when equipped with bow"

2. **Clear Description**
   ```
   - What happened?
   - What should happen?
   - Steps to reproduce
   - Expected vs actual behavior
   ```

3. **Details**
   - Script version
   - Executor used
   - Roblox device type
   - Game status
   - Screenshot/video if applicable

4. **Error Logs**
   - Copy error message dari console (F9)
   - Include any related error trace

### Example Bug Report
```markdown
## Bug: Script crashes on startup

### Description
When I execute script di my alt account, it crash setelah 5 detik.

### Steps to Reproduce
1. Login dengan alt account
2. Execute script di Volcano
3. Wait 5 seconds

### Expected
Script should load dan show notification

### Actual
Game freeze dan crash

### Details
- Version: v1.0.0
- Executor: Volcano
- Device: Windows 10, Roblox Client
- Error: nil index 'UserGui' in UIModule

### Logs
```
[ERROR] UIModule.lua:45 attempt to index nil with 'PlayerGui'
stack traceback:
	UIModule.lua:45: in function 'CreateUI'
	main.lua:120: in function 'Initialize'
```
```

---

### Suggesting Features

Jika ada feature idea:

1. **Check existing issues** - pastikan belum ada
2. **Create Feature Request**
   - Title: "[FEATURE] Brief description"
   - Description: Detailed explanation
   - Use Cases: Kapan feature ini digunakan
   - Alternative Solutions: Alternatives jika ada

### Example Feature Request
```markdown
## [FEATURE] Auto-farm based on moon phase

### Description
Add feature untuk farming based on in-game moon phases. 
Banyak players yang notice certain fish lebih sering caught saat full moon.

### Use Cases
- Maximize catches dengan moon phase detection
- Auto-switch spots based on weather+moon
- Notification saat moon phase optimal

### Implementation Ideas
- Check game time service
- Detect moon phase dari game environment
- Switch spots automatically
```

---

## Code Contribution

### Setup Development Environment

```bash
# 1. Fork repository
#    Click fork button di GitHub

# 2. Clone your fork
git clone https://github.com/YOUR_USERNAME/fish-it-roblox.git
cd fish-it-roblox

# 3. Add upstream (original repo)
git remote add upstream https://github.com/ORIGINAL_OWNER/fish-it-roblox.git

# 4. Create feature branch
git checkout -b feature/your-feature-name
```

### Making Changes

1. **Follow Code Style**
   - Use consistent indentation (2 spaces untuk Lua)
   - Add comments untuk complex logic
   - Use meaningful variable names
   - Follow existing patterns

2. **Write Clean Code**
   ```lua
   -- Good
   function CalculateFishingXP(BaseXP, Multiplier)
       return BaseXP * Multiplier
   end

   -- Bad
   function calc_xp(b, m)
       return b * m
   end
   ```

3. **Test Your Changes**
   - Test locally di executor
   - Verify tidak ada breaking changes
   - Test di different scenarios
   - Check console untuk errors

4. **Update Documentation**
   - Update README.md jika perlu
   - Add comments untuk new features
   - Update CHANGELOG.md

### Committing Changes

```bash
# 1. Stage changes
git add .

# 2. Commit dengan meaningful message
git commit -m "Add feature: auto-weather changing"

# 3. Keep commits logical
#    One feature = one commit
#    Multiple related = multiple commits

# 4. Push to your fork
git push origin feature/your-feature-name
```

### Good Commit Messages

```
Bad:
- "fix"
- "update"
- "lol"
- "asdfghj"

Good:
- "Add auto-weather feature dengan smart rotation"
- "Fix null reference error in WebhookModule"
- "Improve UI responsiveness for mobile devices"
- "Refactor AutomationModule para better performance"
```

### Create Pull Request

1. **Push to your fork**
   ```bash
   git push origin feature/your-feature-name
   ```

2. **Create PR di GitHub**
   - Go to original repository
   - Click "New Pull Request"
   - Select your branch
   - Add title dan description

3. **PR Description Template**
   ```markdown
   ## Description
   Brief description ng changes

   ## Type of Change
   - [ ] Bug fix
   - [ ] New feature
   - [ ] Documentation update
   - [ ] Performance improvement

   ## Related Issues
   Closes #123

   ## Testing Done
   - [ ] Tested locally
   - [ ] No breaking changes
   - [ ] Works sa all modes

   ## Checklist
   - [ ] Code follows style guide
   - [ ] Comments added
   - [ ] Documentation updated
   - [ ] No new warnings
   ```

4. **Address Review Comments**
   - Respond sa feedback
   - Make requested changes
   - Push updates (auto-updates PR)

---

## Development Guidelines

### Module Structure

```lua
-- Template para new module
local ModuleName = {}

-- State
ModuleName.Enabled = false

-- Initialize
function ModuleName.Initialize()
    -- Setup code
end

-- Main function
function ModuleName.Start()
    ModuleName.Enabled = true
end

-- Cleanup
function ModuleName.Stop()
    ModuleName.Enabled = false
end

-- Helper functions (local)
local function HelperFunction()
    -- Helper logic
end

return ModuleName
```

### Error Handling

```lua
-- Good error handling
local function SafeFunction()
    local Success, Error = pcall(function()
        -- Your code here
    end)
    
    if not Success then
        warn("Error in SafeFunction: " .. tostring(Error))
        return nil
    end
    
    return true
end

-- Without proper error handling - BAD!
function BadFunction()
    -- Code that might error
end
```

### Performance Considerations

```lua
-- Use efficient loops
for i = 1, #Table do
    Process(Table[i])
end

-- Avoid inefficient operations
for i, v in pairs(Table) do
    Process(v)  -- Slower iteration
end

-- Cache results
local CachedValue = ExpensiveCalculation()
for i = 1, 100 do
    UseValue(CachedValue)
end
```

---

## Coding Standards

### Naming Conventions

```lua
-- Variables: camelCase
local playerName = "John"
local fishCount = 0

-- Functions: PascalCase
function FishingModule:StartAutomation()
end

-- Constants: UPPER_SNAKE_CASE
local MAX_FISHING_DELAY = 5
local DEFAULT_MODE = "Instant"

-- Local functions: camelCase
local function helperFunction()
end
```

### Comments

```lua
-- Use clear, descriptive comments
function AutoFish()
    -- Check if rod is equipped
    if not HasRod() then return end
    
    -- Calculate wait time based on mode
    local WaitTime = GetWaitTime()
    wait(WaitTime)
    
    -- Cast fishing
    CastRod()
end

-- Avoid obvious comments
-- NOT: local x = 5  -- Set x to 5

-- Document complex logic
-- This implementation uses exponential backoff untuk
-- avoid rate limiting saat fishing requests
local WaitTime = BaseDelay * (2 ^ RetryCount)
```

---

## Testing Checklist

Before submitting PR:

- [ ] Feature works sa intended
- [ ] No breaking changes
- [ ] Tested sa different modes
- [ ] Console errors: None
- [ ] Performance: Acceptable
- [ ] Mobile: Compatible
- [ ] Documentation: Updated
- [ ] Code style: Consistent

---

## Community Guidelines

### Be Respectful
- Treat others sa respect
- Welcome diverse perspectives
- No harassment or discrimination
- Constructive feedback only

### Be Helpful
- Assist other contributors
- Review PRs constructively
- Answer questions patiently
- Share knowledge

### Be Collaborative
- Communicate clearly
- Ask questions if unclear
- Discuss solutions together
- Give credit where due

---

## Reporting Security Issues

⚠️ **DO NOT** create public issue para security vulnerabilities!

Instead:
1. Email: security@fishitscript.dev
2. Include: Description, steps to reproduce, impact
3. Allow 48 hours para response

---

## Contributor License Agreement

By contributing, you agree na:
- Your contributions ay open source
- Licensed under MIT License
- You have rights sa contribute code
- Credit ay shared sa all contributors

---

## Recognition

### Contributors
Lahat ng contributors ay listed sa:
- CONTRIBUTORS.md file
- GitHub contributors page
- Release notes

### Rewards
- Feature improvements: Mentioned sa docs
- Bug fixes: Listed sa changelog
- Major contributions: Special recognition

---

## Common Contribution Areas

### Priority
- **High:** Bug fixes, security issues
- **Medium:** Feature requests, improvements
- **Low:** Documentation, style improvements

### Easy First Issues
- Documentation improvements
- Bug fixes marked "[Good First Issue]"
- Tests para existing features
- Code style improvements

---

## Getting Help

- **Questions:** Create discussion sa GitHub
- **Stuck:** Comment sa issue asking para help
- **Unclear:** Reply sa PR asking para clarification
- **Technical:** Detailed explanation always available

---

## Thank You!

Your contributions ay invaluable sa keeping Fish It script amazing! 

Every bug report, feature suggestion, code contribution, at documentation improvement ay appreciated. 

**Together, we make Fish It better for everyone!** 🐟✨

---

**Last Updated:** December 2025  
**Maintained By:** Fish It Community  
**Status:** Active ✅

Looking forward to your contributions! 🚀
