# 🏙️ Smart City Energy Tracker

A modern, responsive Flutter web dashboard for monitoring smart city energy infrastructure. Built with ForUI component library and featuring real-time energy metrics, interactive charts, and adaptive navigation across mobile, tablet, and desktop devices.

![Flutter](https://img.shields.io/badge/Flutter-3.32.0+-02569B?style=flat&logo=flutter&logoColor=white)
![ForUI](https://img.shields.io/badge/ForUI-0.14.0+-4285F4?style=flat&logo=flutter&logoColor=white)
![Dart](https://img.shields.io/badge/Dart-3.8.0+-0175C2?style=flat&logo=dart&logoColor=white)

## 📋 Project Overview

The Smart City Energy Tracker is a comprehensive dashboard application designed for grid operators, urban planners, and city officials to monitor and manage smart city energy infrastructure. The application provides real-time insights into power generation, consumption, device status, and system efficiency with adaptive navigation patterns optimized for each device type.

### 🎯 Key Features

- **📊 KPI Grid** - Four key performance indicators with real-time metrics
- **⚡ System Efficiency Gauge** - Circular progress indicator showing grid performance (98.7%)
- **📈 Power Trend Chart** - Interactive line chart comparing generation vs consumption
- **🥧 Energy Source Breakdown** - Pie chart displaying renewable energy mix (67.3% renewable)
- **🚨 Active Alerts** - Real-time system notifications with severity levels
- **🔧 Device Status List** - Infrastructure monitoring with online/offline indicators
- **⚡ Quick Actions** - Operator control buttons with ForUI toast feedback
- **🌙 Dark Theme** - Modern dark UI optimized for control room environments
- **📱 Responsive Navigation** - Adaptive navigation patterns for mobile, tablet, and desktop

### 🎨 Navigation Experience by Device

- **📱 Mobile (< 768px):** Bottom navigation with 5-tab layout optimized for thumb navigation
- **📟 Tablet (768px - 1024px):** Collapsible sidebar navigation with auto-collapse behavior
- **🖥️ Desktop (≥ 1024px):** Persistent expanded sidebar with adaptive layout system

## 🛠️ Tech Stack

- **Framework:** Flutter Web (3.32.0+)
- **Language:** Dart (3.8.0+)
- **UI Library:** [ForUI](https://forui.dev) (0.14.0+) - Modern Flutter component library
- **Charts:** [fl_chart](https://pub.dev/packages/fl_chart) (1.0.0+) - Interactive charts
- **Architecture:** Responsive component-based architecture with navigation state management

## 🎨 Design System

- **Background:** `#0F172A` (Dark blue-gray)
- **Containers:** `#1E293B` (Lighter dark blue-gray)  
- **Accent:** `#38BDF8` (Light blue/cyan)
- **Theme:** ForUI Zinc Dark theme with custom color integration
- **Typography:** ForUI typography system with responsive scaling
- **Navigation:** Device-appropriate patterns using ForUI sidebar and custom bottom navigation

## 📱 Responsive Design

**Current Implementation Status: V1.1 (Responsive Layout) - 🚧 In Development**

- **✅ Mobile:** `< 768px` - Bottom navigation with single-column layout (V1.0 Complete)
- **🚧 Tablet:** `768px - 1024px` - Collapsible FSidebar with two-column layouts (V1.1 In Progress)
- **🚧 Desktop:** `≥ 1024px` - Expanded FSidebar with adaptive layout system (V1.1 In Progress)

### Navigation Implementation Status

- **✅ Mobile Bottom Navigation** - Complete with toast feedback for unimplemented sections
- **🚧 Responsive Sidebar** - ForUI FSidebar implementation with responsive behavior
- **🚧 Navigation Controller** - State management for sidebar expansion and section navigation
- **🚧 Adaptive Layouts** - Breakpoint-aware content layouts for tablet/desktop
- **📋 Breadcrumb Navigation** - Planned for desktop layouts using FBreadcrumb

## 🗂️ Project Structure

```
lib/
├── main.dart                          # App entry point with ForUI theme
├── screens/
│   └── dashboard_screen.dart          # Main dashboard screen
├── controllers/
│   └── navigation_controller.dart     # 🚧 Navigation state management
├── utils/
│   └── responsive_utils.dart          # 📋 Responsive breakpoint utilities
├── constants/
│   └── navigation_constants.dart      # 📋 Navigation items and breadcrumbs
├── widgets/
│   ├── layout/
│   │   ├── responsive_scaffold.dart   # 🚧 Main responsive layout with FSidebar
│   │   ├── header.dart                # 🚧 Enhanced header with sidebar toggle
│   │   ├── sidebar.dart               # 🚧 ForUI FSidebar implementation
│   │   ├── main_content.dart          # 🚧 Responsive content layout
│   │   └── bottom_navigation.dart     # ✅ Mobile bottom navigation
│   ├── dashboard/
│   │   ├── kpi_grid.dart              # ✅ KPI metrics grid
│   │   ├── system_efficiency_gauge.dart # ✅ Circular efficiency gauge
│   │   ├── power_trend_chart.dart     # ✅ Line chart for power trends
│   │   ├── energy_source_pie_chart.dart # ✅ Energy source breakdown
│   │   ├── active_alerts.dart         # ✅ System alerts list
│   │   └── device_status_list.dart    # ✅ Device monitoring list
│   └── shared/
│       ├── stat_card.dart             # ✅ Reusable metric card component
│       └── device_list_item.dart      # ✅ Device status item component
└── prds/                              # Product Requirements Documents
    ├── 1.0-smart-city-energy-prd.md   # ✅ V1.0 base implementation
    └── 1.1-responsive-layout-prd.md   # 🚧 V1.1 responsive enhancement spec
```

**Legend:** ✅ Complete | 🚧 In Development | 📋 Planned

## 🚀 Getting Started

### Prerequisites

- Flutter SDK 3.32.0 or higher
- Dart SDK 3.8.0 or higher
- Chrome/Edge/Safari for web development

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/luthfiarifin/forui_vibe_coding_playground
   cd flutter_forui_playground
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Run the application**
   ```bash
   flutter run -d web-server --web-port 8080
   ```

4. **Open in browser**
   ```
   http://localhost:8080
   ```

### Development Commands

```bash
# Run with hot reload
flutter run -d chrome

# Build for production
flutter build web

# Run tests
flutter test

# Analyze code
flutter analyze

# Format code
dart format .
```

## 📊 Dashboard Components

### KPI Grid
- **Total Power:** 847.2 MW (+2.3% from last hour)
- **Grid Efficiency:** 98.7% (Optimal performance)
- **Active Alerts:** 3 (1 critical, 2 warnings)
- **Renewable %:** 67.3% (Solar + Wind active)

### Energy Sources
- **Solar:** 35.2% (298.4 MW Generated)
- **Wind:** 32.1% (Wind Turbine Array B)
- **Natural Gas:** 22.4%
- **Hydro:** 10.3%

### Device Monitoring
- Central Power Grid (Online - 847.2 MW)
- Solar Farm Alpha (Online - 298.4 MW)
- Wind Turbine Array B (Warning - Maintenance Required)
- Battery Storage Unit 1 (Online - 85% Capacity)
- Smart Meter Network (Online - 12,847 Connected)
- Backup Generator 3 (Offline - Scheduled Maintenance)

## 🎯 Current Implementation Status

### V1.0 Features (Complete ✅)
- **Mobile-First Dashboard:** Single-column layout optimized for mobile devices
- **Bottom Navigation:** 5-tab navigation with toast feedback for unimplemented sections
- **ForUI Integration:** Complete usage of ForUI component system (FScaffold, FCard, FButton, FToast)
- **Interactive Charts:** fl_chart powered visualizations with hover effects
- **Dark Theme:** Professional dark mode optimized for dashboards
- **Static Data:** Realistic demo data for all dashboard components

### V1.1 Features (In Development 🚧)
- **Responsive Layouts:** Adaptive layouts for tablet and desktop breakpoints
- **ForUI Sidebar Navigation:** FSidebar with FSidebarGroup and FSidebarItem components
- **Navigation State Management:** NavigationController for sidebar and section state
- **Adaptive Content Layouts:** Two-column (tablet) and three-column (desktop) grid systems
- **Enhanced Header:** Sidebar toggle functionality and breadcrumb navigation
- **Breakpoint Utilities:** Responsive helper functions using ForUI breakpoint system

### Key ForUI Components in Use
- **FScaffold** - Main layout container with sidebar support
- **FSidebar, FSidebarGroup, FSidebarItem** - Navigation hierarchy
- **FCard, FButton, FToast** - UI components and feedback
- **FBreadcrumb, FBreadcrumbItem** - Contextual navigation (planned)
- **FIcons** - Consistent iconography throughout the app

## 📚 Documentation

- **[V1.0 PRD](prds/1.0-smart-city-energy-prd.md)** - ✅ Base implementation requirements
- **[V1.1 PRD](prds/1.1-responsive-layout-prd.md)** - 🚧 Responsive design enhancement specification
- **[ForUI Documentation](https://forui.dev)** - Component library reference
- **[fl_chart Documentation](https://github.com/imaNNeo/fl_chart)** - Chart library reference

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/responsive-sidebar`)
3. Commit your changes (`git commit -m 'Add collapsible sidebar navigation'`)
4. Push to the branch (`git push origin feature/responsive-sidebar`)
5. Open a Pull Request

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

- **[ForUI Team](https://forui.dev)** - For the excellent Flutter component library and responsive design system
- **[fl_chart](https://github.com/imaNNeo/fl_chart)** - For powerful chart components
- **Flutter Team** - For the amazing framework and web platform support
- **Smart City Communities** - For inspiration and real-world use case insights

---

**Built with ❤️ using Flutter, ForUI, and responsive design principles**
