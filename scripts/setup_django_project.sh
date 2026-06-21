#!/usr/bin/env bash
set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Print colored message
print_info() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Check if project name is provided
if [ -z "$1" ]; then
    print_error "Project name is required!"
    echo ""
    echo "Usage: $0 <project-name>"
    echo ""
    echo "Example: $0 goldmarketplace_server"
    exit 1
fi

PROJECT_NAME="$1"
VENV_DIR=".venv"

print_info "Creating Django project: $PROJECT_NAME"
print_info "Virtual environment will be created in: $VENV_DIR"
echo ""

# Step 1: Create virtual environment
print_info "Creating virtual environment..."
python3 -m venv "$VENV_DIR"
print_success "Virtual environment created at $VENV_DIR"

# Step 2: Activate virtual environment
print_info "Activating virtual environment..."
source "$VENV_DIR/bin/activate"
print_success "Virtual environment activated"

# Step 3: Upgrade pip
print_info "Upgrading pip..."
pip install --upgrade pip --quiet
print_success "pip upgraded successfully"

# Step 4: Install Django
print_info "Installing Django..."
pip install django --quiet
print_success "Django installed"

# Step 5: Initialize Django project
print_info "Initializing Django project '$PROJECT_NAME'..."
django-admin startproject "$PROJECT_NAME" .
print_success "Django project initialized"

# Step 6: Create necessary files
print_info "Creating necessary project files..."

# Create requirements.txt
cat > requirements.txt << 'EOF'
django>=5.0
django-cors-headers
django-environ
djangorestframework
djangorestframework-simplejwt
psycopg
python-decouple
requests
EOF
print_success "requirements.txt created"

# Create .env file
cat > .env << 'EOF'
# Django Settings
DEBUG=True
DJANGO_ENV=dev

# Database
DATABASE_URL=postgresql://user:password@localhost:5432/dbname

# Site Settings
ALLOWED_HOSTS=localhost,127.0.0.1

# CORS
CORS_ALLOWED_ORIGINS=http://localhost:3000,http://localhost:8000

# CSRF
CSRF_TRUSTED_ORIGINS=http://localhost:3000,http://localhost:8000

# API Settings
API_BASE_URL=http://localhost:8000/api/v1
EOF
print_success ".env file created"

# Create .gitignore
cat > .gitignore << 'EOF'
# Virtual environment
.venv/
venv/

# Python
__pycache__/
*.py[cod]
*$py.class
*.so
.Python
*.egg-info/
*.egg

# Environment variables
.env
.env.local

# Django
*.log
local_settings.py
db.sqlite3
db.sqlite3-journal

# IDE
.vscode/
.idea/
*.swp
*.swo

# OS
.DS_Store
Thumbs.db

# Production
staticfiles/
media/
EOF
print_success ".gitignore created"

# Create README.md
cat > README.md << EOF
# $PROJECT_NAME

Django project initialized with essential packages.

## Quick Start

1. Activate virtual environment:
   source .venv/bin/activate

2. Install dependencies:
   pip install -r requirements.txt

3. Configure environment variables in .env

4. Run migrations:
   python manage.py migrate

5. Run development server:
   python manage.py runserver

## Project Structure

- $PROJECT_NAME/ - Django project configuration
- manage.py - Django CLI
- requirements.txt - Python dependencies
- .env - Environment variables (configure before running)

## Installed Packages

- Django
- django-cors-headers (for API CORS support)
- django-environ (for environment variables)
- djangorestframework (DRF for APIs)
- djangorestframework-simplejwt (JWT authentication)
- psycopg (PostgreSQL database driver)
- python-decouple (settings separation)
- requests (HTTP client)

EOF
print_success "README.md created"

# Step 7: Install all requirements
print_info "Installing all dependencies from requirements.txt..."
pip install -r requirements.txt --quiet
print_success "All dependencies installed"

# Step 8: Create initial .git (optional)
print_info "Creating initial git repository..."
if command -v git > /dev/null; then
    git init
    git add .
    git commit -m "Initial commit: Django project setup"
    print_success "Git repository initialized"
else
    print_warning "git not found, skipping git initialization"
fi

# Step 9: Create directories
print_info "Creating project directories..."
mkdir -p static media logs
print_success "Directories created: static, media, logs"

# Final summary
echo ""
print_success "=========================================="
print_success "Django project setup completed!"
print_success "=========================================="
echo ""
print_info "Project name: $PROJECT_NAME"
print_info "Virtual environment: $VENV_DIR"
print_info "Project location: $(pwd)"
echo ""
print_info "To start working with your project:"
echo ""
echo "  1. Activate virtual environment:"
echo "     source $VENV_DIR/bin/activate"
echo ""
echo "  2. Configure .env file with your settings"
echo ""
echo "  3. Run migrations:"
echo "     python manage.py migrate"
echo ""
echo "  4. Create superuser:"
echo "     python manage.py createsuperuser"
echo ""
echo "  5. Run development server:"
echo "     python manage.py runserver"
echo ""
print_info "Happy coding!"